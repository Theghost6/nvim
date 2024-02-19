return {
	"sontungexpt/stcursorword",
	event = "VeryLazy",
	config = function()
		require("stcursorword").setup({
			max_word_length = 100,
			min_word_length = 2,
			preview = {
				enable = true,
				delay_ms = 500,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				winhighlight = "NormalFloat:CursorWordPreview",
				winblend = 0,
				position = "above",
			},
		})
	end,
}
