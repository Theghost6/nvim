-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
	return
end

-- enable comment in an autocommand group
vim.cmd([[
  augroup CommentSetup
    autocmd!
    autocmd BufRead,BufNewFile * lua require('Comment').setup()
  augroup END
]])
