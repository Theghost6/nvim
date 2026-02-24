return {
	"sphamba/smear-cursor.nvim",
	opts = {
		cursor_color = "#A9A9A9", -- DarkGray for ghostly look
		normal_bg = "#2F2F2F", -- Bóng của con trỏ hòa tan vào nền xám
		smear_between_neighbor_lines = false, 
		stiffness = 0.3,
		trailing_stiffness = 0.1,
		trailing_exponent = 4, -- Làm vệt bóng dài và mờ tự nhiên hơn tí
		hide_target_hack = true,
		gamma = 1,
	},
}
