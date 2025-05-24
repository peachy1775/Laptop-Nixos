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
    slurp
    swww
    waybar
    wl-clipboard
    wofi
    xorg.xprop

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
    htop
    tree
    unzip
    wget
    zsh

    #file-managers
    xfce.thunar
    xfce.tumbler
    xfce.thunar-volman

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

    # Teams
    teams-for-linux

  ];

}
