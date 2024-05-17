return {
  -- The following configs are needed for fixing lazyvim on nix
  -- force enable telescope-fzf-native.nvim
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
  -- disable mason.nvim, use programs.neovim.extraPackages
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
}
