{ pkgs, username, ... }:

{
  imports = [
    ./hyprland.nix
    ./stylixTargets.nix
    ./fastfetch.nix
    ./vscode.nix
    ./neovim.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/peaches";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "vscode";
      GIT_EDITOR = "vscode";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GTK_USE_PORTAL = "1";
      WLR_NO_HARDWARE_CURSORS = "2";
      XCURSOR_THEME = "Adwaita";

    };

    file = {
      ".config/ghostty" = {
        source = ./config/ghostty;
        recursive = true;
      };
      ".config/starship.toml" = {
        source = ./config/starship.toml;
      };
      ".config/fastfetch/nixos.png" = {
        source = ./config/fastfetch/nixos.png;
      };
      ".config/waybar/config.jsonc" = {
        source = ./config/waybar/config.json;
      };
      ".config/waybar/style.css" = {
        source = ./config/waybar/style.css;
      };
    };

    packages = with pkgs; [
      brave
      blueman
      brightnessctl
      btop
      chromium
      curl
      dunst
      file
      fzf
      gdk-pixbuf
      ghostty
      git
      grim
      gtk3
      htop
      hyprshot
      killall
      mpv
      nil
      nixd
      nushellPlugins.polars
      pavucontrol
      playerctl
      proton-pass
      protonmail-desktop
      ripgrep
      slurp
      swww
      sxiv
      teams-for-linux
      tree
      tmux
      unzip
      vlc
      waybar
      wget
      wl-clipboard
      wofi
      xorg.xprop
      xfce.thunar
      zed-editor
      zsh
      alejandra
      carapace
      screenfetch
      sl
      pipes
      cmatrix
      asciiquarium
      aalib
      nyancat
      bb
      bat
      xfce.tumbler
      networkmanager
      adwaita-icon-theme

    ];
  };

  programs = {

    git = {
      enable = true;
      userName = "Dont_Matta";
      userEmail = "204289133+peachy1775@users.noreply.github.com";
    };

    zed-editor.enable = true;

    nushell = {
      enable = true;
      configFile.source = ./config/config.nu;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };

    nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;
      quickCss = builtins.readFile ./config/vesktop/main.css;
      config = {
        useQuickCss = true;
        themeLinks = [ ];
        frameless = true;
        plugins = {
          betterSettings.enable = true;
          callTimer.enable = true;
          crashHandler.enable = true;
          fixYoutubeEmbeds.enable = true;
          imageZoom.enable = true;
          noF1.enable = true;
          onePingPerDM.enable = true;
          openInApp.enable = true;
          quickReply.enable = true;
          voiceChatDoubleClick.enable = true;
          voiceDownload.enable = true;
          voiceMessages.enable = true;
          volumeBooster = {
            enable = true;
            multiplier = 5;
          };
          webKeybinds.enable = true;
          webScreenShareFixes.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
  # Optional: improve build speed from user-level (limited)
  nixpkgs = {
    config = {
      max-jobs = "auto";
      cores = 0;
    };
  };
}
