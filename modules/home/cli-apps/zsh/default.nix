inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.zsh;
in {
  options.plusultra.cli-apps.zsh = with types; {
    enable = mkBoolOpt false "Whether or not to enable zsh config.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      initExtraFirst = ''
        AUTOCD=1
      '';

      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-autosuggestions"
          "zdharma-continuum/fast-syntax-highlighting kind:defer"
          "zsh-users/zsh-history-substring-search"
          "z-shell/zsh-eza"
          "Aloxaf/fzf-tab"
          # ^R history ^T search files
          "zap-zsh/fzf"
        ];
      };
    };

    programs.eza = {
      enable = true;
      icons = true;
    };
  };
}
