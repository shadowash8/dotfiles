return {
    -- Mason for managing LSP servers
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            auto_install = true, 
        },
        config = true,
        keys = {
            { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
        }
    },
    { 
        "williamboman/mason-lspconfig.nvim"
    },
}
