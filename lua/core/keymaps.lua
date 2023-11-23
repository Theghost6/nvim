local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- Select all, Copy and Paste
keymap("n", "<C-a>", "ggVG", opts)
keymap("v", "<C-c>", "y", opts)
keymap("n", "<C-v>", "p", opts)

-- Move the cursor between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Save
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)

-- Move the line up and down
keymap("n", "<M-Up>", ":m-2<CR>", opts)
keymap("n", "<M-Down>", ":m+<CR>", opts)
keymap("i", "<M-Up>", "<Esc>:m-2<CR>", opts)
keymap("i", "<M-Down>", "<Esc>:m+<CR>", opts)
keymap("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts)

-- Resize window
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Move cursor in Insert Mode
keymap("i", "<M-j>", "<Down>", opts)
keymap("i", "<M-k>", "<Up>", opts)
keymap("i", "<M-h>", "<Left>", opts)
keymap("i", "<M-l>", "<Right>", opts)

-- Next buffers
keymap("n", "<TAB>", "<cmd>bn<CR>", opts)
keymap("n", "<S-TAB>", "<cmd>bp<CR>", opts)

-- Clear search
keymap("n", "<Enter>", "<cmd>nohlsearch<CR>", opts)

-- Rename
map("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- telescope
map("n", "<Space>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
map("n", "<Space>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
map("n", "<Space>fs", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
-- nvim-tree
map("n", "<F4>", "<cmd>NvimTreeToggle<CR>", opts) -- toggle file explorer
map("n", "<F6>", "<cmd>Telescope grep_string<CR>", opts) -- toggle file explorer
map("n", "<F5>", "<cmd>Telescope find_files<CR>", opts) -- toggle file explorer
-- keymap("n", "<F3>", ":!g++ -o %< % && ./%<<CR>",opts)
keymap("n", "<F3>", [[:term g++ -o %< % && ./%<<CR> ]], opts)
--FindCmdline
vim.api.nvim_exec(
	[[
  augroup AutoFormat
    autocmd!
    autocmd BufWritePre *.cpp,*.h :silent! %!clang-format
  augroup END
]],
	false
)
