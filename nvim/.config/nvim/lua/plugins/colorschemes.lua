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
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- require("koda").setup({ transparent = true })
    vim.cmd("colorscheme koda")
  end,
}
}
