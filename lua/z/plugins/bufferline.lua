return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function(_, opts)
		local bufferline = require("bufferline")

		bufferline.setup(opts)

		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(bufferline.nvim_bufferline)
				end)
			end,
		})
	end,
}
