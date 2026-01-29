local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")
local lspconfig = require("lspconfig")
local blink_cmp = require("blink.cmp")

local capabilities = require("blink.cmp").get_lsp_capabilities()

local lsp_configs = {
	lua_ls = {
		filetypes = { "lua" },
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = { vim.env.VIMRUNTIME },
				},
			},
		},
	},
	jsonls = {
		capabilities = capabilities,
		filetypes = { "json", "jsonc" },
	},
	cssls = {
		capabilities = capabilities,
		filetypes = { "css", "scss", "less" },
	},
	yamlls = {
		capabilities = capabilities,
		filetypes = { "yaml" },
	},
	emmet_language_server = {
		capabilities = capabilities,
		filetypes = { "html", "css", "javascriptreact", "typescriptreact", "javascript", "typescript" },
	},
	ts_ls = {
		capabilities = capabilities,
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	eslint = {
		capabilities = capabilities,
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
}

-- Setup for each language server
for server, config in pairs(lsp_configs) do
	config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
	lspconfig[server].setup(config)
end

-- Mason LSP Config
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(lsp_configs),
	automatic_installation = true,
})

-- Diagnostic Virtual Text
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰠠",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, undercurl = true, sp = "Red" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = true, sp = "Yellow" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = true, sp = "Blue" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = true, sp = "Green" })

-- LSP key mappings
utils.nmap_leader("lI", "<cmd>LspInstallInfo<CR>", "Installer Info")
utils.nmap_leader("la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
utils.nmap_leader("lf", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format")
utils.nmap_leader("li", "<cmd>LspInfo<CR>", "Info")
utils.nmap_leader("lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic")
utils.nmap_leader("lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic")
utils.nmap_leader("ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action")
utils.nmap_leader("lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix")
utils.nmap_leader("lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
