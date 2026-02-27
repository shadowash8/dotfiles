return {
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require("mini.basics").setup({
                mappings = {
                    windows = true,
                    move_with_alt = true,
                },
            })

            require("mini.statusline").setup()
            require("mini.tabline").setup()
            require("mini.files").setup()
            require("mini.snippets").setup()
            require("mini.comment").setup()
            require("mini.pairs").setup()
            require("mini.pick").setup()
            require("mini.extra").setup()

            local miniclue = require("mini.clue")
            miniclue.setup({
                clues = {
                    { mode = "n", keys = "<Leader>f", desc = "+Find" },
                    { mode = "n", keys = "<Leader>g", desc = "+Git" },
                    { mode = "n", keys = "<Leader>r", desc = "+Refactor" },
                    { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
                    { mode = "n", keys = "<Leader>l", desc = "+LSP" },
                    { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows({ submode_resize = true }),
                    miniclue.gen_clues.z(),
                },
                triggers = {
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                    { mode = "n", keys = [[\]] },
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "]" },
                    { mode = "x", keys = "[" },
                    { mode = "x", keys = "]" },
                    { mode = "i", keys = "<C-x>" },
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = "`" },
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },
                    { mode = "n", keys = "<C-w>" },
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                },
            })
        end,

        keys = {
            {
                "<leader>e",
                function() require("mini.files").open(vim.uv.cwd(), true) end,
                desc = "Explorer",
            },
        },
    },
}
