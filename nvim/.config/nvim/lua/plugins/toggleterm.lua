return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
        keys = {
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Float" },
            { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
            { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Vertical" },
        }
    },
}
