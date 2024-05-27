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
    apps = {
      wezterm = enabled;
      # kitty = enabled;
      gtk = enabled;
      rime = enabled;
      gnome = enabled;
    };
  };
}
