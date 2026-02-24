return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false, -- tắt thông báo khi tự động lưu
				message = "",
			},
			condition = function(buf)
				-- Phải kiểm tra buffer còn sống không trước khi sờ vào!
				if not vim.api.nvim_buf_is_valid(buf) then
					return false
				end

				-- Bỏ qua file rác, file hệ thống, hoặc buffer không cho phép lưu
				if vim.bo[buf].modifiable and not vim.bo[buf].readonly then
					if not vim.tbl_contains({ "terminal", "nofile", "prompt" }, vim.bo[buf].buftype) then
						if not vim.tbl_contains({ "neo-tree", "TelescopePrompt", "snacks_picker_input", "lazy" }, vim.bo[buf].filetype) then
							-- Bắt buộc phải có tên file mới được save
							if vim.fn.bufname(buf) ~= "" then
								return true 
							end
						end
					end
				end
				return false
			end,
		})
	end,
}
