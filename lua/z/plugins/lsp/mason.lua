return {
  "williamboman/mason.nvim",
  lazy = true,
  event = "VeryLazy", -- Giữ VeryLazy nhưng cải thiện cách xử lý
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Defer setup để tránh blocking UI thread
    vim.defer_fn(function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
        },
        max_concurrent_installers = 2, -- Giảm số lượng cài đặt đồng thời
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "html",
          "cssls",
          "lua_ls", 
          "emmet_ls",
          "pyright",
          "clangd",
          "ts_ls",
        },
        automatic_installation = true,
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "black",
          "pylint", 
          "eslint_d",
          "clang-format",
        },
        auto_update = false,
        run_on_start = false, -- Tắt run_on_start để tránh lag
      })
    end, 50) -- Delay 50ms để UI kịp render
  end,
}
