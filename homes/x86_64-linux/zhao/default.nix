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
      gtk = enabled;
      rime = enabled;
      gnome = enabled;
    };
  };
}
