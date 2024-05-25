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
      git = enabled;
      fastfetch = enabled;
    };
  };
}
