return {
	-- 1. Cài đặt Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			-- Dùng pcall để Neovim không bị crash nếu Treesitter chưa tải xong
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"bash",
					"lua",
					"vim",
					"cpp",
					"python",
					"markdown",
					"markdown_inline",
					"query",
					"vimdoc",
				},
				auto_install = true,
			})
		end,
	},

	-- 2. Cài đặt Rainbow Delimiters độc lập
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			vim.g.rainbow_delimiters = {
				blacklist = {
					"noice",
					"notify",
					"snacks_notif",
					"snacks_notif_history",
					"snacks_picker_input",
					"snacks_picker_list",
					"blink-cmp-menu",
					"nui",
					"TelescopePrompt",
				},
				condition = function(bufnr)
					local ft = vim.bo[bufnr].ft
					local blacklist = {
						["noice"] = true,
						["notify"] = true,
						["snacks_notif"] = true,
						["snacks_notif_history"] = true,
						["snacks_picker_input"] = true,
						["snacks_picker_list"] = true,
						["blink-cmp-menu"] = true,
						["nui"] = true,
						["TelescopePrompt"] = true,
					}
					if blacklist[ft] then
						return false
					end

					-- Only enable if Treesitter parser is available and loaded
					local lang = vim.treesitter.language.get_lang(ft)
					if not lang then
						return false
					end

					local has_parser, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
					return has_parser and parser ~= nil
				end,
			}
		end,
	},

	-- 3. Plugin autotag
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
