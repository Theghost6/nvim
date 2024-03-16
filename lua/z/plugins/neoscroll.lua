return {
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			hide_cursor = true, -- Ẩn con trỏ khi cuộn
			stop_eof = true, -- Dừng cuộn tại cuối file khi cuộn xuống dưới
			respect_scrolloff = false, -- Dừng cuộn khi con trỏ đạt đến biên độ scrolloff của file
			cursor_scrolls_alone = true, -- Con trỏ sẽ tiếp tục di chuyển ngay cả khi cửa sổ không thể cuộn thêm được nữa
			easing_function = nil, -- Hàm dễ dàng mặc định
			pre_hook = nil, -- Hook trước khi bắt đầu cuộn
			post_hook = nil, -- Hook sau khi cuộn kết thúc
			performance_mode = false, -- Chế độ hiệu suất
		})
	end,
}
