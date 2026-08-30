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
				-- Cursor = { fg = "#f09f48", bg = "#f09f48" },
				-- CursorLine = { bg = "#737373" }, -- << cập nhật
				LspReferenceText = { underline = true },
				LspReferenceRead = { underline = true },
				LspReferenceWrite = { underline = true },
				Visual = { bg = "#787878" }, -- thêm dòng này
				GhostText = { fg = "#a9b1d6" }, -- << cập nhật
			},

			extensions = {
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
				treesitter = true,
				treesittercontext = true,
				trouble = true,
				whichkey = true,
			},
		})

		-- Apply colorscheme
		vim.cmd.colorscheme("cyberdream")
	end,
}
