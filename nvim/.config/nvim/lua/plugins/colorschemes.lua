return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                sidebars = { "qf", "help", "NvimTree" },
            })
            -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "drewxs/ash.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme ash]])
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        "oskarnurm/koda.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("koda").setup({ transparent = true })
            vim.cmd("colorscheme koda")
        end,
    }
}
