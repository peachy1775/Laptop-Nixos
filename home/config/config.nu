$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.config.buffer_editor = "code";
$env.editor = "code";

fastfetch

# ENV's
$env.XDG_CONFIG_DIRS = $"($env.XDG_CONFIG_DIRS):($env.HOME)/.config"

# Custom commands instead of aliases with args
def nv [...args] { nvim $args.0 }
def ncim [...args] { nvim $args.0 }
def gc [...args] { git clone $args.0 }
def v [...args] { code $args.0 }
def pic [...args] { imv $args.0 }


# Custom 'cd' command
alias d = cd
alias clr = clear
alias y = yazi
alias usb = yazi /run/media/peaches

# Still works as a regular alias since it's a fixed command
alias nfs = sudo nixos-rebuild switch --flake .#peaches
alias nfu = sudo nixos-rebuild switch --flake .#peaches --update

export def nixos-rbld [] {
  let currDir = $"(pwd)"
  rm -rf $"($env.HOME)/.gtkrc-2.0"
  cd $"($env.HOME)/.nix"
  sudo nix flake update
  sudo nixos-rebuild switch --flake $".#((open config.toml).user.username)" --impure
  cd $currDir
}

export def dev [] {
  nix develop ~/dev
}

def force-quit [] {
  let pids = (run sh -c $"ps --ppid $nu.env.PID -o pid=" | lines)
  $pids | each { |pid| run kill -9 $pid }
  exit
}

def e [] {
  exit
}

# Load zoxide commands
source ~/.config/nushell/zoxide.nu




