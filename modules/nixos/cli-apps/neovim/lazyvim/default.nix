inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.neovim.lazyvim;
in {
  options.plusultra.cli-apps.neovim.lazyvim = 
    let
      pluginsOptionType = with types;
        listOf (oneOf [
          package
          (submodule {
            options = {
              name = mkOption { type = str; };
              path = mkOption { type = package; };
            };
          })
        ]);
    in
    {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
    plugins = mkOption {
      type = pluginsOptionType;
      default = [ ];
      description = "A set of vim plugins to install.";
    };
    extraPlugins = mkOption {
      type = pluginsOptionType;
      default = [ ];
    };

    removedPlugins = mkOption {
      type = pluginsOptionType;
      default = [ ];
    };

    extraSpec = mkOption {
      type = lib.types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    # lazyvim default plugins
    plusultra.cli-apps.neovim.lazyvim.plugins = with pkgs.vimPlugins; [
      LazyVim
      bufferline-nvim
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      conform-nvim
      dashboard-nvim
      dressing-nvim
      flash-nvim
      friendly-snippets
      gitsigns-nvim
      indent-blankline-nvim
      lualine-nvim
      neo-tree-nvim
      neoconf-nvim
      neodev-nvim
      noice-nvim
      nui-nvim
      nvim-cmp
      nvim-lint
      nvim-lspconfig
      nvim-notify
      # nvim-snippets
      nvim-spectre
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-web-devicons
      persistence-nvim
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      vim-illuminate
      vim-startuptime
      which-key-nvim
      {
        name = "LuaSnip";
        path = luasnip;
      }
      {
        name = "catppuccin";
        path = catppuccin-nvim;
      }
      {
        name = "mini.bufremove";
        path = mini-nvim;
      }
      {
        name = "mini.comment";
        path = mini-nvim;
      }
      {
        name = "mini.pairs";
        path = mini-nvim;
      }
    ];

    plusultra.home.extraOptions = {
      programs.neovim = {
        extraPackages = with pkgs; [
          # clipboard
          xclip

          # lazyvim
          lua-language-server
          stylua

          # telescope
          ripgrep
        ];

        plugins = with pkgs.vimPlugins; [ lazy-nvim ];

        extraLuaConfig =
          let
            mkEntryFromDrv =
              drv:
              if lib.isDerivation drv then
                {
                  name = "${lib.getName drv}";
                  path = drv;
                }
              else
                drv;
            lazyPath = pkgs.linkFarm "lazy-plugins" (
              builtins.map mkEntryFromDrv (lib.subtractLists cfg.removedPlugins cfg.plugins ++ cfg.extraPlugins)
            );
          in
          ''
            require("lazy").setup({
              defaults = {
                lazy = true,
              },
              dev = {
                path = "${lazyPath}",
                patterns = { "." },
                fallback = true,
              },
              spec = {
                { "LazyVim/LazyVim", import = "lazyvim.plugins" },
                -- The following configs are needed for fixing lazyvim on nix
                -- force enable telescope-fzf-native.nvim
                { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
                -- disable mason.nvim, use programs.neovim.extraPackages
                { "williamboman/mason-lspconfig.nvim", enabled = false },
                { "williamboman/mason.nvim", enabled = false },
                -- import/override with your plugins
                { import = "plugins" },
                -- treesitter handled by my.neovim.treesitterParsers, put this line at the end of spec to clear ensure_installed
                { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
            ${cfg.extraSpec}  },
            })
          '';
      };
    };

    # treesitter
    plusultra.home.configFile."nvim/parser".source =
      let
        treesitterParsers =
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              python
              c
              csv
              jsonc
              lua
              markdown
              markdown_inline
              regex
            ]
          )).dependencies;
        parsers = pkgs.symlinkJoin {
          name = "treesitter-parsers";
          paths = treesitterParsers;
        };
      in
      "${parsers}/parser";
  };
}
