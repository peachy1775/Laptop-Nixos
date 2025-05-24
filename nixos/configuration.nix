{ config, pkgs, lib, ... }:

{
  imports = [
    ./stylix.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    max-jobs = "auto";
    cores = 0;
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    kernelModules = [ "lenovo-legion" ];
    initrd.kernelModules = [ "nvidia" ];
    blacklistedKernelModules = [ "nouveau" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5;
    };
  };

  networking = {
    hostName = "peachy";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.peaches = {
    isNormalUser = true;
    description = "peaches";
    shell = pkgs.nushell;
    extraGroups = [ "wheel" "networkmanager" "libvirt" "storage" ];
  };

  environment.systemPackages = with pkgs; [
    hyprland
    xwayland
    wl-clipboard
    rofi-wayland
    foot
    wayland-utils
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "16";
      background = "${../home/config/.wallpapers/anom.jpg}";
      loginBackground = true;
    })
  ];

  # Required for SDDM to see Hyprland
  environment.etc."xdg/wayland-sessions/Hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=Hyprland Wayland Compositor
    Exec=Hyprland
    Type=Application
    DesktopNames=Hyprland
  '';

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

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb.layout = "us";
      xkb.options = "eurosign:e,caps:escape";
    };

    displayManager.sddm = {
      enable = true;
      autoLogin.user = "peaches";
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-mocha";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = false;
        scrollMethod = "twofinger";
        accelSpeed = "-1.0";
        accelProfile = "adaptive";
      };
    };

    bluetooth.enable = true;
    blueman.enable = true;
    polkit.enable = true;

    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    getty.autologinUser = "peaches";

    udisks2.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  programs.dconf.enable = true;
  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
