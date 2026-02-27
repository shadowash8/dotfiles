local utils = require("utils")
local blink_cmp = require("blink.cmp")

local lsp_configs = {
    lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = { vim.env.VIMRUNTIME } },
            },
        },
    },
    ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "package.json", "tsconfig.json", ".git" },
    },
}

-- Setup each language server
for server, config in pairs(lsp_configs) do
    config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- Stup mason
require("mason").setup()

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "󰠠",
            [vim.diagnostic.severity.HINT]  = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN]  = "WarningMsg",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
        },
    },
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, undercurl = true, sp = "Red" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = true, sp = "Yellow" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = true, sp = "Blue" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = true, sp = "Green" })

-- LSP keymaps
utils.nmap_leader("la", vim.lsp.buf.code_action, "Code Action")
utils.nmap_leader("lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
utils.nmap_leader("lr", vim.lsp.buf.rename, "Rename")

utils.nmap_leader("ld", vim.lsp.buf.definition, "Go to Definition")
utils.nmap_leader("lc", vim.lsp.buf.declaration, "Go to Declaration")
utils.nmap_leader("lt", vim.lsp.buf.type_definition, "Type Definition")
utils.nmap_leader("lh", vim.lsp.buf.hover, "Hover Documentation")
utils.nmap_leader("ls", vim.lsp.buf.signature_help, "Signature Help")

utils.nmap_leader("le", vim.diagnostic.open_float, "Show Line Diagnostics")
utils.nmap_leader("lq", vim.diagnostic.setloclist, "Diagnostics to Loclist")
