return {
	"sphamba/smear-cursor.nvim",
	opts = {
		smear_between_buffers = true,
		smear_between_neighbor_lines = true,
		scroll_buffer_space = true,
		legacy_computing_symbols_support = true,
		smear_insert_mode = true,

		stiffness = 0.5,
		trailing_stiffness = 0.5,
		damping = 0.67,
		matrix_pixel_threshold = 0.5,
	},
}
