return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		"nvimdev/lspsaga.nvim",
		-- "ray-x/lsp_signature.nvim",
		"ErichDonGubler/lsp_lines.nvim",
		-- { "antosha417/nvim-lsp-file-operations", config = true },
		"saghen/blink.cmp",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("BufReadPost", {
			callback = function()
				local lsp_lines = require("lsp_lines")
				lsp_lines.setup()
        vim.diagnostic.config({ virtual_text = false })
				vim.keymap.set("n", "<Leader>;", lsp_lines.toggle, { desc = "Toggle lsp_lines" })
			end,
		})

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})
		lspconfig["ts_ls"].setup({
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
		lspconfig["eslint"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr) -- gọi lại on_attach gốc

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.cmd("EslintFixAll")
					end,
				})
			end,
		})

		-- configure html server
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "vscode-html-language-server", "--stdio" },
			init_options = {
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			},
		})

		lspconfig["jdtls"].setup({
			cmd = { "jdtls" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("gradlew", ".git", "mvnw")(fname) or vim.fn.getcwd()
			end,
			on_attach = function(client, bufnr)
				-- Các cấu hình on_attach riêng của bạn
			end,
			settings = {
				java = {},
			},
		})
		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		-- --PHP
		-- lspconfig["phpactor"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })
		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		-- c++
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.emmet_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = {
				"css",
				"html",
				"php",
				"javascriptreact",
				"typescriptreact",
			},
			init_options = {
				html = {
					options = {
						-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
						["bem.enabled"] = true,
					},
				},
			},
		}) -- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
