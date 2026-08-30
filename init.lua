-- Tăng tốc độ khởi động bằng Bytecode Cache
if vim.loader then
	vim.loader.enable()
end

require("z.config.options")
require("z.config.keymap")
require("z.lazy")

-- Kiểm tra dependencies (Node, Python, GCC, v.v...) của OS khi chạy nvim trên máy mới
require("z.config.health")
