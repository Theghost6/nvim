local opt = vim.opt -- for conciseness
local g = vim.g -- global variables

-- Thiết lập phím Leader là phím Space (Phím cách)
g.mapleader = " "
g.maplocalleader = " "

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- smart indenting for C-like filetypes

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance (24-bit TrueColor)
opt.termguicolors = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Buffer behavior
opt.hidden = true -- allow hidden background buffers without saving

-- Persistent Undo
opt.undofile = true -- enable persistent undo
opt.undodir = vim.fn.stdpath("state") .. "/undo" -- set undo dir cross-platform

-- tối ưu hiệu suất
opt.updatetime = 250 -- reduce update time for CursorHold events
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.lazyredraw = false -- don't redraw while executing macros or other commands

