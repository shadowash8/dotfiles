return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		auto_install = true,
		indent = { enable = true },
		ensure_installed = {
			"vim",
			"lua",
			"vimdoc",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"markdown",
			"markdown_inline",
			"json",
			"scss",
			"yaml",
			"php",
		},
	},
}
