{ options, config, lib, pkgs, ... }:
with lib;
with lib.plusultra;
let
  cfg = config.plusultra.cli-apps.proxy;
in
{
  options.plusultra.cli-apps.proxy = with types; {
    enable = mkBoolOpt false "Whether or not to enable proxy.";
    wsl = mkBoolOpt false "Whether or not in wsl environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      clash-meta
      proxychains-ng
    ];

    programs.proxychains = {
      enable = true;
      quietMode = true;
      proxies = {
        myproxy =
          {
            enable = ! cfg.wsl;
            type = "socks5";
            host = "127.0.0.1";
            port = 7891;
          };
        wsl =
          {
            enable = cfg.wsl;
            type = "socks5";
            host = "192.168.1.94";
            port = 7890;
          };
      };
    };

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
