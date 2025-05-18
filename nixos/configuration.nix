{ pkgs, lib, ... }:

{
  imports = [
    ./stylix.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    max-jobs = "auto";
    cores = 0;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
  };

  security.polkit.enable = true;

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      videoDrivers = [ "intel" ];
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
    };
  };

  networking = {
    hostName = "peaches";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  services.getty.autologinUser = "peaches";

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1.5";
      QT_SCALE_FACTOR = "1.5";
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
    0.0.0.0 vscode.azureedge.net
    0.0.0.0 marketplace.visualstudio.com
    0.0.0.0 vscode.market.visualstudio.com
    0.0.0.0 default.exp-tas.com
    0.0.0.0 dc.services.visualstudio.com
    0.0.0.0 telemetry.visualstudio.com
    0.0.0.0 settings-prod.api.visualstudio.com
    0.0.0.0 msedge.api.cdp.microsoft.com
    0.0.0.0 az416426.vo.msecnd.net
    0.0.0.0 vortex.data.microsoft.com
    0.0.0.0 go.microsoft.com
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

  # BLUETOOTH #
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.pulseaudio.enable = false;

  # input and display
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*"; # optional but useful
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # VIRT
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

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
      xfce.thunar-volman
      polkit_gnome
      ntfs3g
      ocl-icd
      clinfo
    ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
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
  environment.etc."sbin/mount.ntfs".source = "${pkgs.ntfs3g}/bin/ntfs-3g";
  system.stateVersion = "24.11";
}
