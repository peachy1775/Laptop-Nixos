_: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "DP-4,7680x2160@119.99700,auto,1.875";

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
        border_size = 4;
        "col.active_border" = "rgb(3d85c6)";
        "col.inactive_border" = "rgba(00000000)";
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
        sensitivity = 0.3;
        touchpad = {
          natural_scroll = false;
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
        "SUPER, S, exec,  hyprshot -o /home/peaches/Screenshots -m region"
        "SUPER, 7, exec, swww img ~/Wallpaper/cartoon.jpg --transition-type  random     --transition-fps 60 --transition-duration 1.7"
        "SUPER, 8, exec, swww img ~/Wallpaper/mount.jpg --transition-type random    --transition-fps 60 --transition-duration 1.7"
        "SUPER, 9, exec, swww img ~/Wallpaper/nice.jpg --transition-type  random    --transition-fps 60 --transition-duration 1.7"
        "SUPER, 0, exec, swww img ~/Wallpaper/space.jpg --transition-type random  --transition-fps 60 --transition-duration 1.7"
        "SUPER, minus, exec, swww img ~/Wallpaper/blue.jpg --transition-type  random    --transition-fps 60 --transition-duration 1.7"
        "SUPER, equal, exec, swww img ~/Wallpaper/purp.jpg --transition-type random  --transition-fps 60 --transition-duration 1.7"
        "SUPER, Print, exec, hyprshot -m window "
        "SUPER ALT SHIFT, Q, exit"
        "SUPER LSHIFT, Space, togglefloating"
        "ALT, Return, fullscreen"
        "SUPER, grave, workspace, 1"
        "SUPER SHIFT, grave, movetoworkspace, 1"
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
        ", mouse:275, workspace, e+1"
        ", mouse:276, workspace, e-1"
        ", XF86AudioRaiseVolume, exec, vol --up"
        ", XF86AudioLowerVolume, exec, vol --down"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
      
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
