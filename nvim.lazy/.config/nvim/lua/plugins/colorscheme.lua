return {
    -- add pywal16
    { "nitinbhat972/cwal.nvim" },

    { "bluz71/vim-moonfly-colors" },

    { "oskarnurm/koda.nvim" },

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                styles = {
                    types = "NONE",
                    methods = "NONE",
                    numbers = "NONE",
                    strings = "NONE",
                    comments = "italic",
                    keywords = "bold,italic",
                    constants = "NONE",
                    functions = "italic",
                    operators = "NONE",
                    variables = "NONE",
                    parameters = "NONE",
                    conditionals = "italic",
                    virtual_text = "italic",
                },
            })
        end,
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "cwal",
        },
    },
}
