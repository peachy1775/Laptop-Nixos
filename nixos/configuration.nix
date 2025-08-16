{ pkgs, lib, ... }:
{
  imports = [
    ./stylix.nix
    ./hardware-configuration.nix
  ];


  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    kernelModules = [ "lenovo-legion" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    initrd.kernelModules = [ "nvidia" ];
    blacklistedKernelModules = [ "nouveau" ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
  };

  boot.extraModprobeConfig = ''
  options snd-hda-intel model=auto
  blacklist snd_soc_avs
'';

  security.polkit.enable = true;

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
      };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      libinput.touchpad.disableWhileTyping = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };
    };
  };
  
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      package = pkgs.linuxKernel.packages.linux_6_12.nvidiaPackages.stable;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
  };

  services.udev.extraRules = ''
    ACTION=="add|change", ATTRS{name}=="Touchpad", ENV{LIBINPUT_DISABLE_WHILE_TYPING}="1"
  '';


  networking = {
    hostName = "peachy";
    networkmanager.enable = true;
  };

  #time.timeZone = "America/Denver";

  time.timeZone = "America/Chicago";

  services.getty.autologinUser = "peaches";

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_SCALE_FACTOR = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "48";
      WLR_DPI = "192";
      GTK_USE_PORTAL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  environment.etc."hosts".text = lib.mkForce ''
    127.0.0.1 localhost
    ::1 localhost
    127.0.0.2 peaches
    # VS Code core telemetry and update services
    0.0.0.0 az764295.vo.msecnd.net
    0.0.0.0 vscode-sync.trafficmanager.net
    0.0.0.0 vscode-update.azurewebsites.net
    0.0.0.0 telemetry.visualstudio.com
    0.0.0.0 settings-prod.api.visualstudio.com
    0.0.0.0 msedge.api.cdp.microsoft.com
    0.0.0.0 az416426.vo.msecnd.net
    0.0.0.0 vortex.data.microsoft.com
    #0.0.0.0 go.microsoft.com
    0.0.0.0 errors.edge.microsoft.com
    # Authentication and Microsoft account login
    #0.0.0.0 login.microsoftonline.com
    #0.0.0.0 login.live.com
    #0.0.0.0 aadcdn.msauth.net
    #0.0.0.0 aadcdn.msftauth.net
    # Extension gallery and assets
    0.0.0.0 gallerycdn.vsassets.io
    0.0.0.0 msassets.visualstudio.com
    # Optional - wildcard block (note: /etc/hosts doesn't support wildcards)
    # Use Pi-hole or custom DNS for these
    # *.events.data.microsoft.com  
  '';

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.pulseaudio.enable = false;
  services.dbus.enable = true;
  hardware.bluetooth.settings = {
  General = {
    AutoEnable = true;
    FastConnectable = true;
  };
};


  # Input and Display
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # VIRT
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # This is for USB to work in Thunar
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Creates Group libvirt to usb inside QEMU
  users.groups.libvirt = { };

  users.users.peaches = {
    isNormalUser = true;
    description = "peaches";
    shell = pkgs.nushell;
    extraGroups = [
      "networkmanager"
      "wheel"
      "storage"
      "libvirt"
    ];

    packages = with pkgs; [
      hyprland
      pipewire
      pulseaudio
      qemu
      virt-manager
      wayland
      wireplumber
      xdg-desktop-portal-hyprland
      gvfs
      usbutils
      udiskie
      udisks
      polkit_gnome
      ntfs3g
      ocl-icd
      clinfo
      libinput
      bluez
      bluez-tools
      networkmanagerapplet
      kitty
      alacritty
    ];
  };



  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      font-awesome
      corefonts
      vistafonts
      noto-fonts
      noto-fonts-emoji
      cantarell-fonts
    ];
    fontconfig.defaultFonts.monospace = [ "JetBrainsMono" ];
  };

  programs.hyprland.enable = true;
  networking.firewall.enable = true;
  environment.etc."sbin/mount.ntfs".source = "${pkgs.ntfs3g}/bin/ntfs-3g";
  programs.niri.enable = true;

  system.stateVersion = "24.11";
}
