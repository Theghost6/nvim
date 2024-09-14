return {
	"Pocco81/AutoSave.nvim",
	event = "InsertLeave",
	config = function()
		require("auto-save").setup({
			enabled = true, -- Bật tự động lưu mặc định
			execution_message = {
				message = function()
					return ("Save: saved at " .. vim.fn.strftime("%H:%M:%S"))
				end,
				dim = 0.18,
				cleaning_interval = 1250,
			},
			trigger_events = { "InsertLeave", "TextChanged" },
			-- Sửa đổi hàm condition để chỉ cho phép tự động lưu với các tệp HTML và CSS
			condition = function(buf)
				local fn = vim.fn
				local file_name = fn.expand("%:t") -- Lấy tên tệp hiện tại
				local file_extension = fn.expand("%:e") -- Lấy phần mở rộng của tệp hiện tại

				-- Kiểm tra nếu phần mở rộng là .html hoặc .css
				if file_extension == "html" or file_extension == "css" then
					return true -- Cho phép tự động lưu
				end
				return false -- Không cho phép tự động lưu
			end,
			write_all_buffers = false,
			debounce_delay = 135,
			callbacks = {
				enabling = nil,
				disabling = nil,
				before_asserting_save = nil,
				before_saving = nil,
				after_saving = nil,
			},
		})
	end,
}
