return {
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0, -- Background color opacity in the notification window
				},
			},
			integration = {
				["nvim-tree"] = {
					enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
				},
			},
		},
	},
}
