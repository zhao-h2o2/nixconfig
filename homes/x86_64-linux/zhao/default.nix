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
      neovim = enabled;
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
