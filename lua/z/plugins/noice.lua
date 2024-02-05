return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			config = function(config)
				config.background_colour = "#000000"
				config.fps = 30
				config.icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = "",
				}
				config.level = 2
				config.minimum_width = 50
				config.render = "default"
				config.stages = "fade_in_slide_out"
				config.time_formats = {
					notification = "%T",
					notification_history = "%FT%T",
				}
				config.top_down = true
			end,
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Thêm các tùy chọn ở đây nếu cần
			config = function(_, opts)
				opts.background_color = "#000000"
				require("notify").setup({
					background_colour = "#000000",
				})
			end,
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- Các phần mở rộng hoặc plugins khác bạn muốn thêm vào đây
		},
	},
}
