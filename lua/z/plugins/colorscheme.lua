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
				LspReferenceText = { underline = true },
				LspReferenceRead = { underline = true },
				LspReferenceWrite = { underline = true },
				GhostText = { fg = "#808080" },
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
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = "*",
			callback = function()
				local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = lsp_document_highlight,
					buffer = 0,
					callback = function()
						for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
							if client.supports_method("textDocument/documentHighlight") then
								vim.lsp.buf.document_highlight()
								return
							end
						end
					end,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					group = lsp_document_highlight,
					buffer = 0,
					callback = function()
						vim.lsp.buf.clear_references()
					end,
				})
			end,
		})
	end,
}
