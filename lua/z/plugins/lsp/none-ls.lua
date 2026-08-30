return {
    "nvimtools/none-ls.nvim", -- configure linters / diagnostics
    lazy = true,
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")

        mason_null_ls.setup({
            ensure_installed = {
                "pylint", -- python linter
            },
            automatic_installation = true,
        })

        -- for conciseness
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup({
            root_dir = null_ls_utils.root_pattern(
                ".null-ls-root",
                "Makefile",
                ".git",
                "package.json"
            ),
            sources = {
                diagnostics.pylint,
            },
        })
    end,
}
