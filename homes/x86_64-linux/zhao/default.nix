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
      direnv = enabled;
      git = enabled;
      fastfetch = enabled;
      yazi = enabled;
    };
  };
}
