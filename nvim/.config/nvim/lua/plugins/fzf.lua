return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  keys = {
            {
                "<leader>ff",
                function()
                    require("fzf-lua").files()
                end,
                desc = "Find Files",
            },
            {
                "<leader>fg",
                function()
                    require("fzf-lua").live_grep()
                end,
                desc = "Grep Files",
            },
                        {
                "<leader>fb",
                function()
                    require("fzf-lua").buffers()
                end,
                desc = "Find Buffers",
            },
  },
}
