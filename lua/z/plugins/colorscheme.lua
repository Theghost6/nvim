return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			terminal_colors = false,
			saturation = 1,
			transparent = true,
			variant = "auto",
			cache = false,
			highlights = {
				Cursor = { fg = "#fdf6e3", bg = "#268bd2" },
				CursorLineNr = { fg = "#93a1a1", bold = true },
				-- Highlight từ giống nhau khi trỏ vào
				-- Chỉ gạch chân từ đang trỏ vào và các từ giống nhau
				LspReferenceText = { underline = true },
				LspReferenceRead = { underline = true },
				LspReferenceWrite = { underline = true },
			},
			extention = {
				blinkcmp = true,
				cmp = true,
				dashboard = true,
				fzflua = true,
				hop = true,
				lazy = true,
				markdown = true,
				markview = true,
				noice = true,
				notify = true,
				rainbow_delimiters = true,
				snacks = true,
				telescope = true,
				treesitter = true,
				treesittercontext = true,
				trouble = true,
				whichkey = true,
			},
		})

		-- Apply colorscheme
		vim.cmd.colorscheme("cyberdream")

		-- Tăng tốc độ phản hồi CursorHold
		vim.o.updatetime = 300

		-- Tự động highlight từ dưới con trỏ (LSP style)
		vim.cmd([[
			augroup LspCursorHighlight
				autocmd!
				autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
			augroup END
		]])
	end,
}
