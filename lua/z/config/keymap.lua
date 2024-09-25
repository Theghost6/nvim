local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local keymap = vim.api.nvim_set_keymap

map("n", "<C-a>", "ggVG", opts, { desc = "Select All" })
map("v", "<C-c>", "y", opts, { desc = "Copy" })
-- map("n", "<C-v>", "p", opts, { desc = "Paste" }

map(
	"n",
	"j",
	'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
	{ expr = true },
	{ desc = "Move Cursor Down (Allow Wrapped)" }
)
map(
	"n",
	"k",
	'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
	{ expr = true },
	{ desc = "Move Cursor Up (Allow Wrapped)" }
)

map("n", "<C-h>", "<C-w>h", opts, { desc = "Move Cursor Left Buffer" })
map("n", "<C-j>", "<C-w>j", opts, { desc = "Move Cursor Down Buffer" })
map("n", "<C-k>", "<C-w>k", opts, { desc = "Move Cursor Up Buffer" })
map("n", "<C-l>", "<C-w>l", opts, { desc = "Move Cursor Right Buffer" })

map("n", "<C-s>", "<cmd>w<CR>", opts, { desc = "Save" })
map("i", "<C-s>", "<ESC>:w<CR>", opts, { desc = "Save (Insert)" })

map("n", "<M-Up>", ":m-2<CR>", opts, { desc = "Move Line Up" })
map("n", "<M-Down>", ":m+<CR>", opts, { desc = "Move Line Down" })
map("i", "<M-Up>", "<Esc>:m-2<CR>", opts, { desc = "Move Line Up (Insert)" })
map("i", "<M-Down>", "<Esc>:m+<CR>", opts, { desc = "Move Line Down (Insert)" })
map("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts, { desc = "Move Line Up (Visual)" })
map("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts, { desc = "Move Line Down (Visual)" })

map("n", "<C-Up>", ":resize +2<CR>", opts, { desc = "Resize Window Up" })
map("n", "<C-Down>", ":resize -2<CR>", opts, { desc = "Resize Window Down" })
map("n", "<C-Left>", ":vertical resize +2<CR>", opts, { desc = "Resize Window Left" })
map("n", "<C-Right>", ":vertical resize -2<CR>", opts, { desc = "Resize Window Right" })

map("i", "<M-j>", "<Down>", opts, { desc = "Move Cursor Down in Insert Mode" })
map("i", "<M-k>", "<Up>", opts, { desc = "Move Cursor Up in Insert Mode" })
map("i", "<M-h>", "<Left>", opts, { desc = "Move Cursor Left in Insert Mode" })
map("i", "<M-l>", "<Right>", opts, { desc = "Move Cursor Right in Insert Mode" })

map("n", "<TAB>", "<cmd>bn<CR>", opts, { desc = "Next Buffer" })
map("n", "<S-TAB>", "<cmd>bp<CR>", opts, { desc = "Previous Buffer" })
map("n", "<leader>mh", ":wincmd H<CR>", opts, { "Move Left Buffer" })
map("n", "<leader>ml", ":wincmd L<CR>", opts, { "move Right Buffer" })
map("n", "<leader>mj", ":wincmd J<CR>", opts, { "move Down Buffer" })
map("n", "<leader>mk", ":wincmd K<CR>", opts, { "move Up Buffer" })

map("n", "<Enter>", "<cmd>nohlsearch<CR>", opts, { desc = "Clear Highlight" })

keymap("n", "<F3>", ":RunCode<CR>", opts)
-- keymap("n", "<F3>", [[:term g++ -o %< % && ./%<<CR> ]], opts)
keymap(
	"n",
	"<C-f>",
	"<cmd>lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 1000 })<CR>",
	opts
)
keymap(
	"i",
	"<C-f>",
	"<cmd>lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 1000 })<CR>",
	opts
)

keymap("n", "<F9>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opts)
-- Mở cửa sổ mới
map("n", "<leader>s", ":split<CR>", opts)
map("n", "<leader>v", ":vsplit<CR>", opts)
map("n", "<leader>q", ":close<CR>", opts, { "close split" })

--close Buffer
map("n", "<leader>bd", ":bd<CR>", opts, { "Close Buffer" })
-- WhichKey
map("n", "<leader>w", ":WhichKey<CR>", opts)
keymap("n", "<leader>rw", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
--nếu mà không clipboard được trong wsl hãy cài thử wl-clipboard
