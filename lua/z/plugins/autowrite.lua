return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false, -- tắt thông báo khi tự động lưu
				message = "",
			},
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")
				
				-- Bỏ qua file rác, file hệ thống, hoặc buffer không cho phép lưu
				if fn.getbufvar(buf, "&modifiable") == 1 and
				   utils.not_in(fn.getbufvar(buf, "&buftype"), { "terminal", "nofile", "prompt" }) and
				   utils.not_in(fn.getbufvar(buf, "&filetype"), { "neo-tree", "TelescopePrompt", "snacks_picker_input" }) then
					-- Bắt buộc phải có tên file mới được save
					if fn.bufname(buf) ~= "" then
						return true 
					end
				end
				return false
			end,
		})
	end,
}
