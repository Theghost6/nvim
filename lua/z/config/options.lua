local opt = vim.opt -- for conciseness
local g = vim.g -- global variables
-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line
--opt.cursorword = false
-- vim.o.guicursor = "n-v-c:block,i-ci:ver25-Cursor,r-cr:hor20-Cursor"

-- vim.api.nvim_command("highlight Cursor gui=reverse guifg=NONE guibg=#00ff00")
-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- have to use iterm2 or any other true color terminal
opt.termguicolors = false
-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true
-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
--24bits
vim.opt.termguicolors = false
-- tối ưu hiệu xuất
-- opt.lazyredraw = true -- don't redraw while executing macros or other commands
opt.updatetime = 250 -- reduce update time for CursorHold events
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)

-- tự động indent
opt.smartindent = true -- smart indenting for C-like filetypes
opt.autoindent = true -- copy indent from current line when starting a new line
-- tắt lazydraw 
opt.lazyredraw = true -- don't redraw while executing macros or other commands
