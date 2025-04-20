return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvimdev/lspsaga.nvim",
			{ "ErichDonGubler/lsp_lines.nvim", branch = "main" },
			"Saghen/blink.cmp",
			{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local keymap = vim.keymap

			-- Tích hợp blink.cmp capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Thiết lập diagnostics & lsp_lines
			local ok_lsp_lines, lsp_lines = pcall(require, "lsp_lines")
			if ok_lsp_lines then
				-- Không gọi lsp_lines.setup() ngay lập tức
				-- Đảm bảo không bật virtual_lines khi vào Neovim
				vim.diagnostic.config({ virtual_lines = false, virtual_text = false })

				-- Chỉ toggle khi bạn nhấn <Leader>;
				keymap.set("n", "<Leader>;", function()
					require("lsp_lines").toggle()
				end, { desc = "Toggle lsp_lines" })
			else
				print("Không thể tải plugin lsp_lines!")
			end

			vim.diagnostic.config({
				virtual_text = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})

			-- on_attach dùng chung
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					{ desc = "Show LSP references", buffer = bufnr }
				)
				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ desc = "Show LSP definitions", buffer = bufnr }
				)
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ desc = "Show LSP implementations", buffer = bufnr }
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ desc = "Show LSP type definitions", buffer = bufnr }
				)
				keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ desc = "See available code actions", buffer = bufnr }
				)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename", buffer = bufnr })
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Show buffer diagnostics", buffer = bufnr }
				)
				keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					{ desc = "Show line diagnostics", buffer = bufnr }
				)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = bufnr })
				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = bufnr })
				keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation", buffer = bufnr })
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = bufnr })
			end

			-- Các server
			lspconfig.ts_ls.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"html",
				},
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					workingDirectory = { mode = "auto" },
					format = { enable = true },
					lintTask = { enable = true },
				},
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = { css = true, javascript = true },
					provideFormatter = true,
				},
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.stylelint_lsp.setup({
				filetypes = { "css", "scss", "less" },
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern(".stylelintrc", ".stylelintrc.json", "package.json"),
				settings = {
					stylelintplus = {
						autoFixOnSave = true,
						autoFixOnFormat = true,
					},
				},
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "css", "html", "javascriptreact", "typescriptreact" },
				init_options = {
					html = { options = { ["bem.enabled"] = true } },
				},
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						completion = { workspaceWord = true },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			lspconfig.jdtls.setup({
				cmd = { "jdtls" },
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("gradlew", ".git", "mvnw"),
			})
		end,
	},

	-- lspsaga.nvim
	{
		"nvimdev/lspsaga.nvim",
		event = { "LspAttach" },
		config = function()
			require("lspsaga").setup({
				ui = {
					border = "rounded",
					code_action = "💡",
					diagnostic = "🐞",
				},
				lightbulb = { enable = false },
			})
		end,
	},
}
