{ options, config, lib, pkgs, ... }:
with lib;
with lib.plusultra;
let
  cfg = config.plusultra.cli-apps.proxychains;
in
{
  options.plusultra.cli-apps.proxychains = with types; {
    enable = mkBoolOpt false "Whether or not to enable proxy.";
  };

  config = mkIf cfg.enable {
    programs.proxychains = {
      enable = true;
      quietMode = true;
      proxies = {
        myproxy = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 7891;
        };
      };
    };

    environment.shellAliases = {
      proxychains = "proxychains4";
    };
  };
}
