return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
				close_on_exit = true,
				direction = "float",
				-- float_opts = {
				-- 	border = "single", -- Kiểu đường viền, có thể là "single", "double", "shadow", "rounded", hoặc "none"
				-- 	width = 90, -- Chiều rộng của cửa sổ floating
				-- 	height = 0.9, -- Chiều cao của cửa sổ floating, tính theo phần trăm của chiều cao màn hình
				-- 	winblend = 3, -- Độ mờ của cửa sổ floating, giá trị từ 0 (không mờ) đến 100 (hoàn toàn mờ)
				-- 	highlights = {
				-- 		border = "Normal", -- Hiệu ứng màu sắc của đường viền
				-- 		background = "Normal", -- Màu nền của cửa sổ
				-- },
				-- },
			})
			vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>:ToggleTermToggleAll<CR>", { noremap = true })
		end,
	},
}
