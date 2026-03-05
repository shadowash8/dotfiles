return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = true,
		keys = {
			{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},

	-- Bridges Mason installs → vim.lsp automatically
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = { "lua_ls", "ts_ls" },
			automatic_installation = true,
		},
	},

	-- Formatter runner (prettier, stylua, etc.)
	{
		"stevearc/conform.nvim",
		lazy = false,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},
}
