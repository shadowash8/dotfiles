return {
  {
    "Wansmer/treesj",
    lazy = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = { { "<space>j", "<cmd>TSJToggle<CR>", desc = "Toggle Split/Join" } },
    requires = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false
    },
  },
}
