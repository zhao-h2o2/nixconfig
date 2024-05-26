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
      direnv = enabled;
      git = enabled;
      fastfetch = enabled;
      yazi = enabled;
    };
    apps = {
      wezterm = enabled;
      # kitty = enabled;
      # foot = enabled;
      gtk = enabled;
    };
  };
}
