return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = function()
		require("hop").setup({
			keys = "etovxqpdygfblzhckisuran",
		})

		-- Thiết lập keymap cho tìm từ
		vim.api.nvim_set_keymap(
			"n",
			"<leader>w",
			"<cmd>lua require('hop').hint_words()<cr>",
			{ noremap = true, silent = true }
		)

		-- Thiết lập keymap cho tìm dòng
		vim.api.nvim_set_keymap(
			"n",
			"<leader>l",
			"<cmd>lua require('hop').hint_lines()<cr>",
			{ noremap = true, silent = true }
		)

		-- Thiết lập keymap cho tìm ký tự
		vim.api.nvim_set_keymap(
			"n",
			"<leader><leader>",
			"<cmd>lua require('hop').hint_char1()<cr>",
			{ noremap = true, silent = true }
		)
	end,
}
