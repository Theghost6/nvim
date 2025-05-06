return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy-load khi mở file
    dependencies = {
      { "nvimdev/lspsaga.nvim", event = "LspAttach" },
      { "ErichDonGubler/lsp_lines.nvim", branch = "main", cond = function() return pcall(require, "lsp_lines") end },
      { "Saghen/blink.cmp", cond = function() return pcall(require, "blink.cmp") end },
      { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local keymap = vim.keymap

      -- Tích hợp blink.cmp capabilities nếu có
      local capabilities
      if pcall(require, "blink.cmp") then
        capabilities = require("blink.cmp").get_lsp_capabilities()
      else
        capabilities = vim.lsp.protocol.make_client_capabilities()
      end

      -- Thiết lập diagnostics
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false, -- Tắt lsp_lines mặc định
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        update_in_insert = false, -- Giảm cập nhật diagnostics khi gõ
      })

      -- Toggle lsp_lines
      if pcall(require, "lsp_lines") then
        keymap.set("n", "<Leader>;", function()
          require("lsp_lines").toggle()
        end, { desc = "Toggle lsp_lines" })
      end

      -- on_attach chung
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local mappings = {
          { "n", "gr", "<cmd>Telescope lsp_references<CR>", "Hiển thị tham chiếu LSP" },
          { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Xem các hành động mã có sẵn" },
          { "n", "<leader>rn", vim.lsp.buf.rename, "Đổi tên thông minh" },
          { "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Hiển thị chẩn đoán lỗi trong bộ đệm" },
          { "n", "<leader>d", vim.diagnostic.open_float, "Hiển thị chẩn đoán lỗi trên dòng" },
          { "n", "[d", vim.diagnostic.goto_prev, "Đi đến chẩn đoán lỗi trước đó" },
          { "n", "]d", vim.diagnostic.goto_next, "Đi đến chẩn đoán lỗi tiếp theo" },
          { "n", "K", vim.lsp.buf.hover, "Hiển thị tài liệu" },
          { "n", "<leader>rs", ":LspRestart<CR>", "Khởi động lại LSP" },
        }
        for _, map in ipairs(mappings) do
          keymap.set(map[1], map[2], map[3], vim.tbl_extend("force", opts, { desc = map[4] }))
        end
      end

      -- Cấu hình các LSP server
      local servers = {
        -- Giữ ts_ls cho React/JavaScript
        ts_ls = {
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "html" },
          root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
          single_file_support = true,
          init_options = {
            preferences = {
              disableSuggestions = true,
              includeCompletionsForModuleExports = true, -- Hỗ trợ module cục bộ
              includeFileExtensions = { ".jsx", ".js", ".tsx", ".ts" }, -- Nhận diện file JSX
            },
          },
        },
        eslint = {
          settings = { workingDirectory = { mode = "auto" }, format = { enable = true }, lintTask = { enable = true } },
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
          root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
        },
        html = {
          init_options = { configurationSection = { "html", "css", "javascript" }, embeddedLanguages = { css = true, javascript = true }, provideFormatter = true },
        },
        cssls = {},
        stylelint_lsp = {
          filetypes = { "css", "scss", "less" },
          root_dir = lspconfig.util.root_pattern(".stylelintrc", ".stylelintrc.json", "package.json"),
          settings = { stylelintplus = { autoFixOnSave = true, autoFixOnFormat = true } },
        },
        -- Giữ emmet_ls cho React
        emmet_ls = {
          filetypes = { "css", "html", "javascriptreact", "typescriptreact" },
          init_options = { html = { options = { ["bem.enabled"] = true } } },
        },
        -- Giữ pyright cho Python
        pyright = {
          filetypes = { "python" },
          root_dir = lspconfig.util.root_pattern(".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json"),
          settings = {
            pyright = {
              disableOrganizeImports = false,
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        lua_ls = {
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
        },
        -- Xóa clangd và jdtls nếu không dùng C/C++ hoặc Java
        -- clangd = {},
        -- jdtls = {
        --   cmd = { "jdtls" },
        --   root_dir = lspconfig.util.root_pattern("gradlew", ".git", "mvnw"),
        -- },
      }

      -- Thiết lập tất cả server
      for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
        config.on_attach = config.on_attach or on_attach
        lspconfig[server].setup(config)
      end
    end,
  },

  -- lspsaga.nvim
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = { border = "rounded", code_action = "💡", diagnostic = "🐞" },
        lightbulb = { enable = false }, -- Tắt lightbulb để giảm tải
        diagnostic = { max_height = 0.6, max_width = 0.7 }, -- Giới hạn kích thước cửa sổ diagnostic
      })
    end,
  },
}
