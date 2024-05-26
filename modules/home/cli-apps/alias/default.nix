inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.alias;
in {
  options.plusultra.cli-apps.alias = with types; {
    enable = mkBoolOpt false "Whether or not to enable alias.";
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      # simplify
      c = "clear";

      # proxy
      set_proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890";
      unset_proxy="unset https_proxy http_proxy all_proxy";

      # Colorize grep output (good for log files)
      grep="grep --color=auto";
      egrep="egrep --color=auto";
      fgrep="fgrep --color=auto";

      # confirm before overwriting something
      cp="cp -iv";
      mv="mv -iv";
      rm="rm -vI";
      bc="bc -ql";
    };
  };
}
