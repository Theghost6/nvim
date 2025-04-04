return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	opts = function()
		return {
			transparent = false,
			vim.cmd.colorscheme("solarized-osaka"),
		}
	end,
}
