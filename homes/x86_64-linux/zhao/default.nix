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
      gtk = enabled;
      rime = enabled;
      gnome = enabled;
    };
  };
}
