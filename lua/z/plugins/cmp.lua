return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"onsails/lspkind.nvim", -- vs-code like pictograms
		-- "mattn/emmet-vim",
	},
	config = function()
		local cmp = require("cmp")
		vim.api.nvim_set_hl(0, "MyNormal", { bg = "#282a36", fg = "white" })
		local compare = cmp.config.compare

		local luasnip = require("luasnip")
		local treesitter = require("nvim-treesitter.ts_utils")

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = " ",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = " ",
			Misc = " ",
		}
		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
				maxwidth = function(_, width)
					return math.min(width * 0.6, 80)
				end,
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(function()
					if not check_backspace() then
						cmp.complete()
					end
				end, { "i", "c" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}, -- sources for autocompletion
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					entry_filter = function(entry, context)
						local kind = entry:get_kind()
						local node = treesitter and treesitter.get_node_at_cursor() or nil
						local node_type = node and node:type() or nil

						if node_type == "arguments" then
							if kind == 6 then
								return true
							else
								return false
							end
						end
						return true
					end,
				},
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" },
				{ name = "cmdline" }, -- file system paths
				{ name = "emmet_ls" },
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = function(_, vim_item)
					vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
					return vim_item
				end,
			},
			--Border
			window = {
				completion = cmp.config.window.bordered({
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					winhighlight = "Normal:,FloatBorder:,CursorLine:PmenuSel,Search:Error",
				}),
			},

			sorting = {
				comparators = {
					compare.exact,
					function(entry1, entry2)
						local result = vim.stricmp(entry1.completion_item.label, entry2.completion_item.label)
						if result < 0 then
							return true
						end
						local kind_mapper = require("cmp.types").lsp.completionItemKind or {}
						local kind_score = {
							[kind_mapper.Text or ""] = 1,
							[kind_mapper.Method or ""] = 2,
							[kind_mapper.Function or ""] = 3,
							[kind_mapper.Variable or ""] = 4,
						}
						local kind1 = kind_score[entry1:get_kind()] or 100
						local kind2 = kind_score[entry2:get_kind()] or 100
						return kind1 < kind2
					end,
				},
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			experimental = {
				ghost_text = true,
				native_menu = false,
			},
		})
	end,
}
