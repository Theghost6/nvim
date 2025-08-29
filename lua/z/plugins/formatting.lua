return {
	"stevearc/conform.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang-format" },
        php = {"php-cs-fixer"},
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})
		-- vim.cmd(
		-- 	[[autocmd BufWritePre * :lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 1000 })]]
		-- )
	end,
}
