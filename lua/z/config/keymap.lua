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
map("n", "<leader>mh", "<cmd>wincmd H<CR>", { desc = "Move Window Left" })
map("n", "<leader>ml", "<cmd>wincmd L<CR>", { desc = "Move Window Right" })
map("n", "<leader>mj", "<cmd>wincmd J<CR>", { desc = "Move Window Down" })
map("n", "<leader>mk", "<cmd>wincmd K<CR>", { desc = "Move Window Up" })

map("n", "<Enter>", "<cmd>nohlsearch<CR>", { desc = "Clear Highlight" })

map("n", "<F3>", "<cmd>RunCode<CR>", { desc = "Run Code" })
map("n", "<leader>r", "<cmd>RunCode<CR>", { desc = "Run Code" })

map(
	{ "n", "i" },
	"<C-f>",
	function()
		require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
	end,
	{ desc = "Format Buffer" }
)

map("n", "<F9>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle Terminal" })

-- Quản lý cửa sổ Split
map("n", "<leader>s", "<cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>q", "<cmd>close<CR>", { desc = "Close Split" })

-- Quản lý Buffer
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close Current Buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })
map("n", "<leader>rw", vim.lsp.buf.rename, { desc = "Smart Rename" })
map("n", "<leader>?", "<cmd>WhichKey<CR>", { desc = "Show All Keymaps (WhichKey)" })

-- Cấu hình Clipboard 2 chiều siêu mượt cho WSL
if vim.fn.has("wsl") == 1 then
  if vim.fn.executable("win32yank.exe") == 1 then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  elseif vim.fn.executable("/mnt/c/Windows/System32/clip.exe") == 1 then
    vim.g.clipboard = {
      name = "clip-wsl",
      copy = {
        ["+"] = "/mnt/c/Windows/System32/clip.exe",
        ["*"] = "/mnt/c/Windows/System32/clip.exe",
      },
      paste = {
        ["+"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
        ["*"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
      },
      cache_enabled = 0,
    }
  end
end


