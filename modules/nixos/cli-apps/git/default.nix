{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.cli-apps.git;
  user = config.plusultra.user;
in
{
  options.plusultra.cli-apps.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git gitflow ];

    plusultra.home.extraOptions = {
      programs = {
        git = {
          enable = true;
          inherit (cfg) userName userEmail;
          lfs = enabled;
          extraConfig = {
            init = { defaultBranch = "main"; };
            pull = { rebase = true; };
            push = { autoSetupRemote = true; };
            core = { whitespace = "trailing-space,space-before-tab"; };
            safe = {
              # directory = "${config.users.users.${user.name}.home}/work/config";
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

        # lazygit
        lazygit = {
          enable = true;
        };
        zsh.shellAliases = {
          lg = "lazygit";
        };
      };
    };
  };
}
