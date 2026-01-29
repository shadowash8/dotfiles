return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local signs = require('gitsigns')
            signs.setup {
                signs                        = {
                    add          = { text = '▎' },
                    change       = { text = '▎' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
            }
        end,
        keys = {
            { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",       desc = "Next Hunk" },
            { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",       desc = "Prev Hunk" },
            { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",      desc = "Blame" },
            { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",    desc = "Preview Hunk" },
            { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",      desc = "Reset Hunk" },
            { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",    desc = "Reset Buffer" },
            { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",      desc = "Stage Hunk" },
            { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
            { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                   desc = "Diff" },
        }
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitCurrentFile",
            "LazyGitFilterCurrentFile",
            "LazyGitFilter",
        },
        keys = {
            { "<Leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
        },
        config = function()
            vim.g.lazygit_floating_window_scaling_factor = 0.95
        end,
    }
}
