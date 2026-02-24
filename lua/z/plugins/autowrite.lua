return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false, -- tắt thông báo khi tự động lưu
				message = "",
			},
		})
	end,
}
