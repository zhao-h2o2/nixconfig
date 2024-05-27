{
  lib,
  pkgs,
  config,
  osConfig ? {},
  format ? "unknown",
  namespace,
  ...
}:
with lib.${namespace}; {
  plusultra = {
    cli-apps = {
      alias = enabled;
      zsh = enabled;
      neovim = enabled;
      direnv = enabled;
    };
    apps = {
      wezterm = enabled;
      # kitty = enabled;
      # foot = enabled;
      gtk = enabled;
      rime = enabled;
      gnome = enabled;
    };
  };
}
