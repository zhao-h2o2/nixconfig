return {
  {
    "danymat/neogen",
    config = {
      snippet_engine = "luasnip",
    },
    keys = {
      { "<leader>nf", ":lua require('neogen').generate()<CR>", desc = "generate annotations using neogen" },
    },
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
}
