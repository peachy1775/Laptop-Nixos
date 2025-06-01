{ pkgs, ... }:
{

  home.packages = with pkgs; [
    #fun-terminal
    aalib
    asciiquarium
    bb
    cmatrix
    nyancat
    pipes
    screenfetch
    sl

    #browsers
    brave
    chromium

    #hyprland
    hyprshot
    killall
    swww
    waybar
    wl-clipboard
    wofi
    xorg.xprop
    waypaper
    hyprlock

    #audio-media
    mpv
    pavucontrol
    playerctl

    #system-utils
    blueman
    brightnessctl
    btop
    curl
    dunst
    file
    fzf
    gdk-pixbuf
    gzip
    tree
    unzip
    wget
    zsh
    bottom

    #file-managers
    xfce.thunar
    xfce.tumbler
    xfce.thunar-volman
    nodejs


    #dev-tools
    alejandra
    bat
    bfg-repo-cleaner
    carapace
    git
    nil
    nixd
    nushellPlugins.polars
    ripgrep

    #proton
    proton-pass
    protonmail-desktop
    protonvpn-gui

    #image-graphics
    imv
    spice-gtk

    #misc
    gtk3
    gcc

    # Teams
    teams-for-linux
  ];

}
