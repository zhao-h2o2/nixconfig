inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.neovim;
in {
  options.plusultra.cli-apps.neovim = with types; {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];

    environment.variables = {
      PAGER = "less";
      MANPAGER = "less";
      NPM_CONFIG_PREFIX = "$HOME/.npm-global";
      EDITOR = "nvim";
    };

    plusultra.home = {
      configFile."nvim" = {
        source = ./nvim;
        recursive = true;
      };

      # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
      configFile."nvim/parser".source =
        let
          parsers = pkgs.symlinkJoin {
            name = "treesitter-parsers";
            paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
              c
              lua
            ])).dependencies;
          };
        in
        "${parsers}/parser";

      extraOptions = {
        # Use Neovim for Git diffs.
        programs.zsh.shellAliases.vimdiff = "nvim -d";
        programs.bash.shellAliases.vimdiff = "nvim -d";
        programs.fish.shellAliases.vimdiff = "nvim -d";
      };
    };
  };
}
