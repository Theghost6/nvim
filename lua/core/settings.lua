vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

local options = {
	-- NUMBER
	number = true,
	relativenumber = true,
	numberwidth = 2,
	-- INDENT
	expandtab = false,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	smartindent = true,
	autoindent = true,
	cindent = true,
	-- OTHER
	smartcase = true,
	ignorecase = true,
	fileencoding = "utf-8",
	encoding = "utf-8",
	backup = false,
	clipboard = "unnamedplus",
	writebackup = false,
	swapfile = false,
	completeopt = { "menu", "menuone", "noselect" },
	pumheight = 10,
	backspace = "indent,eol,start",
	undofile = true,
	mouse = "a",
	mousemoveevent = true,
	cursorline = false,
	title = true,
	conceallevel = 0,
	hlsearch = true,
	showmode = true,
	showtabline = 1,
	laststatus = 3,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 500,
	updatetime = 300,
	wrap = true,
	list = true,
	splitkeep = "screen",
}

local globals = {
	mapleader = "\\",
}

vim.opt.listchars = "tab:  "
vim.opt.fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.shortmess:append("sI")
vim.opt.formatoptions:remove("c", "r", "o")

local builtins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"logipat",
	"matchit",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
	"archlinux",
	"fzf",
	"tutor_mode_plugin",
	"sleuth",
	"vimgrep",
}

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
