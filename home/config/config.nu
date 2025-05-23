$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.config.buffer_editor = "code";
$env.editor = "code";

screenfetch

# ENV's
$env.XDG_CONFIG_DIRS = $"($env.XDG_CONFIG_DIRS):($env.HOME)/.config"

# Custom commands instead of aliases with args
def nv [...args] { nvim $args.0 }
def ncim [...args] { nvim $args.0 }
def gc [...args] { git clone $args.0 }
def v [...args] { code $args.0 }

# Custom 'cd' command
alias d = cd

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
alias clear = do {
  ^clear
  screenfetch
}
def ff [] {
  let selected = (fzf | into string | str trim)
  code $selected
}
export def dev [] {
  nix develop --command nu
}

