{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.cli-apps.git;
in
{
  options.plusultra.cli-apps.git = with types; {
    enable = mkBoolOpt false "Whether or not to install git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git gitflow lazygit];
  };
}
