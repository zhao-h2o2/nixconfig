{ options, config, lib, pkgs, ... }:
with lib;
with lib.plusultra;
let
  cfg = config.plusultra.services.clash;
in
{
  options.plusultra.services.clash = with types; {
    enable = mkBoolOpt false "Whether or not to enable clash service.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      clash-meta
    ];

    systemd.services.clash = {
      enable = true;
      description = "A rule based proxy in Go.";
      after = ["network.target"];
      unitConfig = {
        After = "network.target";
      };
      serviceConfig = {
        ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d /home/${config.plusultra.user.name}/.config/clash";
        Restart = "on-abort";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
