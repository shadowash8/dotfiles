return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#11140f',
				base01 = '#11140f',
				base02 = '#80897e',
				base03 = '#80897e',
				base04 = '#d2ddd0',
				base05 = '#f9fff8',
				base06 = '#f9fff8',
				base07 = '#f9fff8',
				base08 = '#ffb49f',
				base09 = '#ffb49f',
				base0A = '#bbe8b0',
				base0B = '#a7fda4',
				base0C = '#e4ffde',
				base0D = '#bbe8b0',
				base0E = '#d6ffcc',
				base0F = '#d6ffcc',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#80897e',
				fg = '#f9fff8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#bbe8b0',
				fg = '#11140f',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#80897e' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e4ffde', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d6ffcc',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#bbe8b0',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#bbe8b0',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#e4ffde',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a7fda4',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d2ddd0' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d2ddd0' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#80897e',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
