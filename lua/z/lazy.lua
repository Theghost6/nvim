local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "z.plugins" }, { import = "z.plugins.lsp" } }, {
	install = {

		 -- colorscheme = { "cyberdream.nvim" },
		-- colorscheme = { "solarized-osaka.nvim" },
	},
	checker = {
		enabled = true,
		notify = false, --false
	},
	change_detection = {
		notify = false, --false
	},
})
-- vim.cmd("autocmd VimEnter * lua require('lazy').install()")
