return {
	"rcarriga/nvim-notify",
	opts = {},
	config = function()
		local notify = require("notify")
		local ascii_art = [[
 /\_/\
( o.o )
 > ^ <]]

		notify(ascii_art)
		notify.setup({
			-- background_colour = "#000000",
			fps = 60,
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			level = 2,
			minimum_width = 50,
			render = "default",
			stages = "fade_in_slide_out",
			time_formats = {
				notification_history = "%FT%T",
				notification = "%T",
			},
			timeout = 5000,
			top_down = false,
		})
	end,
}
