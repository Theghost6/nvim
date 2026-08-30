-- Tự động lưu file siêu nhẹ (Native Auto-Save không cần plugin ngoài)
return {
	dir = vim.fn.stdpath("config"),
	name = "native_autosave",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local augroup = vim.api.nvim_create_augroup("NativeAutoSave", { clear = true })

		local function save_buffer(buf)
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local bo = vim.bo[buf]
			if bo.modifiable and not bo.readonly and bo.buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" and vim.api.nvim_get_option_value("modified", { buf = buf }) then
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent! noautocmd write")
				end)
			end
		end

		vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
			group = augroup,
			pattern = "*",
			callback = function(args)
				save_buffer(args.buf)
			end,
		})
	end,
}

