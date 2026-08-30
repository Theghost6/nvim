return {
	"smoka7/hop.nvim",
	-- event = "BufRead",
	-- branch = "v2",
	config = function()
		require("hop").setup({
			keys = "etovxqpdygfblzhckisuran",
		})

		local map = vim.keymap.set
		local hop = require("hop")

		map("n", "<leader>w", function() hop.hint_words() end, { desc = "Hop to Word" })
		map("n", "<leader>l", function() hop.hint_lines() end, { desc = "Hop to Line" })
		map("n", "<leader><leader>", function() hop.hint_char1() end, { desc = "Hop to Char" })
	end,
}
