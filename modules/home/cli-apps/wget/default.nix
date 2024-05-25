{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
{
  config = {
    xdg.configFile."wgetrc".text = "";
  };
}
