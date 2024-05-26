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
          "MichaelAquilina/zsh-you-should-use"
        ];
      };
    };

    programs = {
      eza = {
        enable = true;
        icons = true;
      };
      starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red) ";
            vicmd_symbol = "[](bold blue) ";
          };
        };
      };
    };
  };
}
