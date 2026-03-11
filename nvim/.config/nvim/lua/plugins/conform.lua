return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			yaml = { "yamlfmt" },
			html = { "prettierd" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			css = { "prettierd" },
			php = { "php_cs_fixer" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
