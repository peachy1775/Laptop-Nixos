_: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "eDP-1,2560x1600@240.00Hz,auto,2";

      # Auto-launing
      exec-once = [
        "hyprctl dispatch workspace 1"
        "ghostty &"
        "brave &"
        "waybar &"
        "swww-daemon &"
        "hyprctl dispatch workspace 1"
      ];

      # General settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
      };

      decoration = {
        rounding = 15;
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          noise = 0.1;
        };
      };

      animations = {
        enabled = true;
      };

      # Inputs (keyboard & mouse)
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = false;
          scroll_factor = 0.2;
        };
      };

      render = {
        explicit_sync = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Keybinds
      bind = [
        "SUPER, Q, exec, ghostty"
        "SUPER, Z, exec, code"
        "SUPER, D, exec, vesktop"
        "SUPER, F, exec, thunar"
        "SUPER, Space, exec, wofi --show drun"
        "SUPER, B, exec, brave"
        "SUPER, C, killactive"
        "SUPER, P, exec, proton-pass"
        "SUPER, M, exec, proton-mail"
        "SUPER, T, exec, teams-for-linux"
        "SUPER, V, exec, virt-manager"
        "SUPER, L, exec, pavucontrol"
        "SUPER, K, exec,  blueman-manager"
        "SUPER, S, exec,  hyprshot -o /home/peaches/Downloads -m region"
        "SUPER ALT SHIFT, Q, exit"
        "SUPER LSHIFT, Space, togglefloating"
        "ALT, Return, fullscreen"
        "SUPER, grave, workspace, 1"
        "SUPER SHIFT, `, movetoworkspace, 1"
        "SUPER, 1, workspace, 2"
        "SUPER SHIFT, 1, movetoworkspace, 2"
        "SUPER, 2, workspace, 3"
        "SUPER SHIFT, 2, movetoworkspace, 3"
        "SUPER, 3, workspace, 4"
        "SUPER SHIFT, 3, movetoworkspace, 4"
        "SUPER, 4, workspace, 5"
        "SUPER SHIFT, 4, movetoworkspace, 5"
        "SUPER, 5, workspace, 6"
        "SUPER SHIFT, 5, movetoworkspace, 6"
        "SUPER, 6, workspace, 7"
        "SUPER SHIFT, 6, movetoworkspace, 7"
        "SUPER, mouse_up, workspace, e+1"
        "SUPER, mouse_down, workspace, e-1"
        ", XF86AudioRaiseVolume, exec, vol --up"
        ", XF86AudioLowerVolume, exec, vol --down"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, MINUS, exec, brightnessctl set 10%-"
        "SUPER, EQUAL, exec, brightnessctl set 10%+"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      windowrulev2 = [
        "pin, title:Picture-in-Picture"
        "float, title:Picture-in-Picture"
        "size 640 360, title:Picture-in-Picture"
        "pin, title:Picture-in-Picture"
      ];
    };
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
