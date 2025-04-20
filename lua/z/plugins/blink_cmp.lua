return {
	"saghen/blink.cmp",
	version = vim.g.lazyvim_blink_main and "*" or "1.*",
	build = vim.g.lazyvim_blink_main and "cargo build --release",
	opts_extend = {
		"sources.completion.enabled_providers",
		"sources.compat",
		"sources.default",
	},
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/Luasnip",

		{
			"saghen/blink.compat",
			optional = true,
			opts = {},
			version = vim.g.lazyvim_blink_main and "*" or "1.*",
		},
	},
	event = "InsertEnter",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = {
			expand = function(snippet, _)
				-- Kiểm tra nếu LazyVim tồn tại
				if vim.g.LazyVim then
					return vim.LazyVim.cmp.expand(snippet)
				else
					return require("luasnip").lsp_expand(snippet) -- Fallback nếu LazyVim không có sẵn
				end
			end,
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
		},
		sources = {
			compat = {},
			default = { "lsp", "path", "snippets", "buffer" },
		},
		cmdline = {
			enabled = false,
		},
		keymap = {
		preset = "enter",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-y>"] = { "show", "hide" },
			["<C-space>"] = { "show_documentation", "hide_documentation" },		},
	},

	---@param opts blink.cmp.Config | { sources: { compat: string[] } }
	config = function(_, opts)
		-- Setup compat sources
		local enabled = opts.sources.default
		for _, source in ipairs(opts.sources.compat or {}) do
			opts.sources.providers[source] = vim.tbl_deep_extend(
				"force",
				{ name = source, module = "blink.compat.source" },
				opts.sources.providers[source] or {}
			)
			if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
				table.insert(enabled, source)
			end
		end

		-- Unset custom prop to pass blink.cmp validation
		opts.sources.compat = nil

		-- Check if we need to override symbol kinds
		for _, provider in pairs(opts.sources.providers or {}) do
			if provider.kind then
				local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
				local kind_idx = #CompletionItemKind + 1

				CompletionItemKind[kind_idx] = provider.kind
				CompletionItemKind[provider.kind] = kind_idx

				local transform_items = provider.transform_items
				provider.transform_items = function(ctx, items)
					items = transform_items and transform_items(ctx, items) or items
					for _, item in ipairs(items) do
						item.kind = kind_idx or item.kind
						item.kind_icon = vim.LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
					end
					return items
				end

				provider.kind = nil
			end
		end

		require("blink.cmp").setup(opts)
	end,
}
