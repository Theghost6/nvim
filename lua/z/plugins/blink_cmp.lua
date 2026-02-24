return {
    "saghen/blink.cmp",
    version = "*",
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
            opts = {},
            version = "*",
        },
    },
    event = "VeryLazy",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        snippets = {
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
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
                -- enabled = vim.g.ai_cmp,
        enabled = true,
    
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
            enabled = true,
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == '/' or type == '?' then return { 'buffer' } end
                if type == ':' then return { 'cmdline' } end
                return {}
            end,
            completion = {
                menu = { auto_show = true },
            },
        },
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-y>"] = { "show", "hide" },
            ["<C-space>"] = { "show_documentation", "hide_documentation" },
        },
    },

}
