_: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo.source = "~/.config/fastfetch/nixos.png";
      logo.width = 35;
      display.separator = " ";
      modules = [
        {
          type = "custom";
          format = "╭─────────────────────────────────────────────────────╮";
        }
        {
          type = "os";
          key = "    OS:";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "    Kernel:";
          keyColor = "red";
        }
        {
          type = "command";
          key = "  󱦟  OS Age:";
          keyColor = "31";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  󱫐  Uptime:";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "  󰏓  Packages:";
          keyColor = "green";
        }
        {
          type = "wm";
          key = "    WM:";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "    Shell:";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "    Terminal:";
          keyColor = "yellow";
        }
        {
          type = "localip";
          key = "    Local IP:";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "╰─────────────────────────────────────────────────────╯";
        }
        "break"
        {
          type = "title";
          key = "  :";
        }
        {
          type = "custom";
          format = "╭─────────────────────────────────────────────────────╮";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "    CPU:";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{2}";
          key = "    GPU:";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{3}";
          key = "    GPU Driver:";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "    Memory:";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  󰋊  Disk:";
          keyColor = "green";
        }
        {
          type = "custom";
          key = " ";
          format = "╰─────────────────────────────────────────────────────╯";
        }
      ];
    };
  };
}
