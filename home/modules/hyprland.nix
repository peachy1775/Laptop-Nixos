_: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "eDP-1,2560x1600@240,auto,2";

      # Auto-launing
      exec-once = [
        "hyprctl dispatch workspace 1"
        "ghostty &"
        "waybar &"
        "swww-daemon &"
        "udiskie &"
        "hyprctl dispatch workspace 1"
      ];

      misc = {
        middle_click_paste = false;
      };

      # General settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 4;
        "col.active_border" = "rgb(1e1e2e)";
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
        sensitivity = 0.1;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
          tap-to-click = true;
          drag_lock = false;
          scroll_factor = 0.1;
          };
        };

      
      wayland.windowManager.hyprland.settings = {
        windowrulev2 = [
        "workspace 1 silent, class:^(com.mitchellh.ghostty)$"
        "workspace 2 silent, class:^(Brave-browser)$"
        "workspace 3 silent, class:^(Code)$"
        "workspace 4 silent, class:^(libreoffice-startcenter)$"
        "workspace 5 silent, class:^(teams-for-linux)$"
        ];
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
        "SUPER, L, exec, libreoffice"
        "SUPER, K, exec,  blueman-manager"
        "SUPER, S, exec,  hyprshot -o /home/peaches/Screenshots -m region"
        "SUPER, N, exec,  hyprlock & sleep 1 && systemctl suspend"
        "SUPER, O, exec, libreoffice"
        "SUPER, 7, exec, swww img ~/Wallpaper/color.png --transition-type  random     --transition-fps 60 --transition-duration 1.7"
        "SUPER, 8, exec, swww img ~/Wallpaper/Foff.jpg --transition-type random    --transition-fps 60 --transition-duration 1.7"
        "SUPER, 9, exec, swww img ~/Wallpaper/moon.jpg --transition-type  random    --transition-fps 60 --transition-duration 1.7"
        "SUPER, 0, exec, swww img ~/Wallpaper/night.jpg --transition-type random  --transition-fps 60 --transition-duration 1.7"
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
        "SUPER, MINUS, exec, brightnessctl set 10%-"
        "SUPER, EQUAL, exec, brightnessctl set 10%+"
        ", mouse:274, exec,"
      
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
