return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      PATH = "append", -- Ensures mason binaries are in Neovim's path
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
        "lua_ls", 
        "pyright",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "black",
        "pylint", 
      },
      auto_update = false,
      run_on_start = true, -- Enable run_on_start to ensure plug-and-play installation on fresh clones
    })
  end,
}

