return {
  "saghen/blink.cmp",
  lazy = false, -- Tắt lazy load để ưu tiên khởi động ngay lập tức
  dependencies = { 
    "rafamadriz/friendly-snippets",
    {
      "zbirenbaum/copilot.lua",
      lazy = true,
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = { ["*"] = true },
        })
      end,
    },
    "giuxtaposition/blink-cmp-copilot",
  },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { 
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono"
    },
    sources = {
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
    completion = {
      ghost_text = { enabled = true },
    },
    signature = { enabled = true }
  },
}
