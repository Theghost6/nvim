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
        "L3MON4D3/LuaSnip",
        {
            "zbirenbaum/copilot.lua",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    suggestion = { enabled = false }, -- Disable suggestions to avoid conflicts with blink-cmp
                    panel = { enabled = false }, -- Disable panel if not needed
                    filetypes = {
                        ["*"] = true, -- Enable Copilot for all filetypes
                    },
                })
            end,
        },
        "giuxtaposition/blink-cmp-copilot",
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
                if vim.g.LazyVim then
                    return vim.LazyVim.cmp.expand(snippet)
                else
                    return require("luasnip").lsp_expand(snippet)
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
                auto_show = false,
                auto_show_delay_ms = 200,
            },
            ghost_text = {
                enabled = vim.g.ai_cmp,
            },
        },
        sources = {
            compat = {},
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },
        cmdline = {
            enabled = false,
        },
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-y>"] = { "show", "hide" },
            ["<C-space>"] = { "show_documentation", "hide_documentation" },
        },
    },

    ---@param opts blink.cmp.Config
    config = function(_, opts)
        -- Cache frequently accessed fields
        local sources = opts.sources
        local providers = sources.providers or {}
        local enabled = sources.default

        -- Setup compat sources
        for _, source in ipairs(sources.compat or {}) do
            providers[source] =
                vim.tbl_deep_extend("force", { name = source, module = "blink.compat.source" }, providers[source] or {})
            if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
                table.insert(enabled, source)
            end
        end

        -- Remove custom property to pass validation
        sources.compat = nil

        -- Override symbol kinds if needed
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        for _, provider in pairs(providers) do
            if provider.kind then
                local kind_idx = CompletionItemKind[provider.kind]
                if not kind_idx then
                    kind_idx = #CompletionItemKind + 1
                    CompletionItemKind[kind_idx] = provider.kind
                    CompletionItemKind[provider.kind] = kind_idx
                end

                local transform_items = provider.transform_items
                provider.transform_items = function(ctx, items)
                    items = transform_items and transform_items(ctx, items) or items
                    for _, item in ipairs(items) do
                        item.kind = kind_idx
                        item.kind_icon = vim.LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon
                    end
                    return items
                end

                provider.kind = nil
            end
        end

        -- Final setup
        require("blink.cmp").setup(opts)
    end,
}
