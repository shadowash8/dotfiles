return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local status_ok, lualine = pcall(require, "lualine")
			if not status_ok then
				return
			end

			lualine.setup({
				options = {
					theme = "cwal16",
					icons_enabled = true,
					disabled_filetypes = { statusline = { "alpha", "NvimTree" } },
				},
			})
		end,
	},
}
