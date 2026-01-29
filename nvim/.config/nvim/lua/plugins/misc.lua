return {
    { "sitiom/nvim-numbertoggle" },
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "neovim/nvim-lspconfig", -- optional
        },
        opts = {},                   -- your configuration
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,           -- Auto close tags
                    enable_rename = true,          -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
            })
        end,
    },
}
