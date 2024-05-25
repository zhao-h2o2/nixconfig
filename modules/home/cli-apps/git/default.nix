{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.git;
  user = config.${namespace}.user;
in {
  options.${namespace}.cli-apps.git = {
    enable = mkEnableOption "Git";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        inherit (cfg) userName userEmail;
        lfs = enabled;
        extraConfig = {
          init = {defaultBranch = "main";};
          pull = {rebase = true;};
          push = {autoSetupRemote = true;};
          core = {whitespace = "trailing-space,space-before-tab";};
          safe = {
            directory = "${user.home}/work/config";
          };
          http.proxy = "socks5h://localhost:7891";
          https.proxy = "socks5h://localhost:7891";
        };
      };

      # ssh ProxyCommand
      ssh = {
        enable = true;
        extraConfig = ''
          Host github
            HostName github.com
            ProxyCommand nc -x 127.0.0.1:7890 %h %p
        '';
      };

      zsh = {
        enable = true;
        shellAliases = {
          lg = "lazygit";
        };
      };
    };
  };
}
