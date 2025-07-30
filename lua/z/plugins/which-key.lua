local icons = require("z.lib.icons")
return {
	"folke/which-key.nvim", --a'kajsbdkhabs'
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 30,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		icons = {
			breadcrumb = icons.ui.ArrowOpen,
			separator = icons.ui.Arrow,
			group = "",
			keys = {
				Space = icons.ui.Rocket,
			},
			rules = false, -- enable auto icon rules
		},
		win = {
			no_overlap = true,
			border = "rounded",
			width = 0.3, -- thu nhỏ width để phù hợp bên phải
			height = { min = 5, max = 25 },
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
			-- Đặt popup ở bên phải
			row = 1, -- giữa màn hình theo chiều dọc
			col = 0.9, -- đặt popup bắt đầu từ 70% màn hình (bên phải)
			wo = {
				winblend = 0, -- loại bỏ transparency để trùng màu nền
			},
		},
		layout = {
			width = { min = 20 },
			spacing = 6,
			align = "right", -- căn phải trong popup cho phù hợp
		},
		show_help = false,
		show_keys = true,
		triggers = {
			{ "<auto>", mode = "nvisoct" },
			{ "<leader>", mode = { "n", "v" } },
		},
	},
}
