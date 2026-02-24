-- Kiểm tra các dependencies thiết yếu của hệ điều hành trên máy mới
local function check_system_dependencies()
	local dependencies = {
		{ cmd = "npm", name = "Node.js (npm)", reason = "Cần thiết cho phần lớn các LSPs (TSServer, HTML, CSS, Tailwind) và Formatters (Prettier)." },
		{ cmd = "python3", name = "Python 3", reason = "Cần thiết cho Pyright (LSP Python) và các tools như Black, Pylint." },
		{ cmd = "gcc", name = "GCC / C Compiler", reason = "Bắt buộc để nvim-treesitter có thể biên dịch (compile) bộ phân tích cú pháp (Parsers)." },
		{ cmd = "rg", name = "ripgrep", reason = "Động cơ tìm kiếm siêu tốc, cần thiết cho Telescope (live_grep)." },
		{ cmd = "fd", name = "fd-find", reason = "Công cụ tìm file siêu nhanh, thay thế lệnh find cho Telescope." },
		{ cmd = "cargo", name = "Rust (Cargo)", reason = "Đôi khi cần thiết cho các plugin phải build từ mã nguồn Rust (ví dụ: blink.cmp core)." },
	}

	local missing = {}

	for _, dep in ipairs(dependencies) do
		if vim.fn.executable(dep.cmd) == 0 then
			table.insert(missing, string.format("• %s: %s", dep.name, dep.reason))
		end
	end

	if #missing > 0 then
		-- Trì hoãn thông báo để giao diện kịp khởi động
		vim.defer_fn(function()
			local msg = "Neovim của bạn phát hiện thiếu một số công cụ hệ thống (OS Dependencies) để hoạt động với 100% công lực:\n\n"
				.. table.concat(missing, "\n\n")
				.. "\n\nHãy chạy lệnh cài đặt trên Terminal (Ubuntu/Debian):\nsudo apt install -y nodejs npm python3 python3-pip python3-venv gcc rustc cargo ripgrep fd-find"
			
			vim.notify(msg, vim.log.levels.WARN, { title = "System Health Check" })
		end, 2000)
	end
end

-- Chạy check khi khởi động
check_system_dependencies()
