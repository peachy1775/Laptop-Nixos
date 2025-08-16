$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.config.buffer_editor = "code";
$env.editor = "code";

fastfetch

# ENV's
$env.XDG_CONFIG_DIRS = $"($env.XDG_CONFIG_DIRS):($env.HOME)/.config"

# Custom commands instead of aliases

def gc [...args] { git clone $args.0 }
def v [...args] { code $args.0 }
def pic [...args] { imv $args.0 }


# Custom 'cd' command
alias d = cd
alias clr = clear
alias y = yazi
alias usb = yazi /run/media/peaches
alias vi = nvim
alias ncim = nvim
alias vim = nvim
alias nv = nvim

# Still works as a regular alias since it's a fixed command
alias nfs = sudo nixos-rebuild switch --flake .#peaches

export def nfu [] {
  let currDir = (pwd)
  cd $"($env.HOME)/.dotfiles"
  sudo nix flake update
  sudo nixos-rebuild switch --flake .#peaches
  cd $currDir
}

export def dev [] {
  nix develop ~/dev
}

def force-quit [] {
  let self_pid = $nu.env.PID
  let children = (run sh -c $"ps --ppid ($self_pid) -o pid=" | lines)
  $children | each {|pid| run kill -9 $pid }
  run kill -9 $self_pid
}

def e [] {
  exit
}

# Load zoxide commands
source ~/.config/nushell/zoxide.nu




