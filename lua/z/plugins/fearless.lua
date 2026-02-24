return {
	"windwp/windline.nvim",
	config = function()
		local windline = require("windline")
		local helper = require("windline.helpers")
		local utils = require("windline.utils")
		local sep = helper.separators
		local animation = require("wlanimation")
		local efffects = require("wlanimation.effects")
		local b_components = require("windline.components.basic")

		local state = _G.WindLine.state
		local lsp_comps = require("windline.components.lsp")
		local hl_list = {
			Black = { "white", "black" },
			Inactive = { "InactiveFg", "InactiveBg" },
			Active = { "ActiveFg", "ActiveBg" },
		}
		local basic = {}

		basic.divider = { "%=", "" }
		basic.space = { " ", "" }
		basic.line_col = { [[ %3l:%-2c ]], hl_list.Black }
		basic.progress = { [[%3p%% ]], hl_list.Black }
		basic.bg = { " ", "StatusLine" }
		basic.file_name_inactive = { "%f", hl_list.Inactive }
		-- basic.line_col_inactive = { [[ %3l:%-2c ]], hl_list.Inactive }
		-- basic.progress_inactive = { [[ %3p%% ]], hl_list.Inactive }

		utils.change_mode_name({
			["n"] = { " NORMAL", "Normal" },
			["no"] = { " O-PENDING", "Visual" },
			["nov"] = { " O-PENDING", "Visual" },
			["noV"] = { " O-PENDING", "Visual" },
			["no"] = { " O-PENDING", "Visual" },
			["niI"] = { " NORMAL", "Normal" },
			["niR"] = { " NORMAL", "Normal" },
			["niV"] = { " NORMAL", "Normal" },
			["v"] = { " VISUAL", "Visual" },
			["V"] = { " V-LINE", "Visual" },
			[""] = { " V-BLOCK", "Visual" },
			["s"] = { " SELECT", "Visual" },
			["S"] = { " S-LINE", "Visual" },
			[""] = { " S-BLOCK", "Visual" },
			["i"] = { " INSERT", "Insert" },
			["ic"] = { " INSERT", "Insert" },
			["ix"] = { " INSERT", "Insert" },
			["R"] = { " REPLACE", "Replace" },
			["Rc"] = { " REPLACE", "Replace" },
			["Rv"] = { "V-REPLACE", "Normal" },
			["Rx"] = { " REPLACE", "Normal" },
			["c"] = { " COMMAND", "Command" },
			["cv"] = { " COMMAND", "Command" },
			["ce"] = { " COMMAND", "Command" },
			["r"] = { " REPLACE", "Replace" },
			["rm"] = { " MORE", "Normal" },
			["r?"] = { " CONFIRM", "Normal" },
			["!"] = { " SHELL", "Normal" },
			["t"] = { " TERMINAL", "Command" },
		})

		local colors_mode_rev = {
			Normal = { "white", "black_light" },
			Insert = { "white", "black_light" },
			Visual = { "white", "black_light" },
			Replace = { "white", "black_light" },
			Command = { "white", "black_light" },
		}

		basic.vi_mode = {
			name = "vi_mode",
			hl_colors = {
				Normal = { "white", "blue" },
				Insert = { "black", "red" },
				Visual = { "black", "magenta" },
				Replace = { "black", "cyan" },
				Command = { "black", "yellow" },
			},
			text = function()
				return " " .. state.mode[1] .. " "
			end,
			hl = function()
				return state.mode[2]
			end,
		}

		basic.vi_mode_sep = {
			name = "vi_mode_sep",
			hl_colors = {
				Normal = { "blue", "FilenameBg" },
				Insert = { "red", "FilenameBg" },
				Visual = { "magenta", "FilenameBg" },
				Replace = { "cyan", "FilenameBg" },
				Command = { "yellow", "FilenameBg" },
			},
			text = function()
				return sep.right_filled
			end,
			hl = function()
				return state.mode[2]
			end,
		}

		basic.file_name = {
			text = function()
				local name = vim.fn.expand("%:p:t")
				if name == "" then
					name = "[No Name]"
				end
				return name .. " "
			end,
			hl_colors = { "FilenameFg", "FilenameBg" },
		}
		local status_color = ""
		local change_color = function(target_color)
			target_color = target_color or "blue"

			-- Force color change on first run by tracking initialized state
			if not _G.windline_anim_initialized then
				_G.windline_anim_initialized = true
			elseif status_color == target_color then
				return
			end

			status_color = target_color

			local anim_colors = {}
			if target_color == "red" then
				anim_colors = {
					"#FFEBEE",
					"#FFCDD2",
					"#EF9A9A",
					"#E57373",
					"#EF5350",
					"#F44336",
					"#E53935",
					"#D32F2F",
					"#C62828",
					"#B71C1C",
				}
			elseif target_color == "magenta" then
				anim_colors = {
					"#F3E5F5",
					"#E1BEE7",
					"#CE93D8",
					"#BA68C8",
					"#AB47BC",
					"#9C27B0",
					"#8E24AA",
					"#7B1FA2",
					"#6A1B9A",
					"#4A148C",
				}
			elseif target_color == "cyan" then
				anim_colors = {
					"#E0F7FA",
					"#B2EBF2",
					"#80DEEA",
					"#4DD0E1",
					"#26C6DA",
					"#00BCD4",
					"#00ACC1",
					"#0097A7",
					"#00838F",
					"#006064",
				}
			elseif target_color == "yellow" then
				anim_colors = {
					"#FFFDE7",
					"#FFF9C4",
					"#FFF59D",
					"#FFF176",
					"#FFEE58",
					"#FFEB3B",
					"#FDD835",
					"#FBC02D",
					"#F9A825",
					"#F57F17",
				}
			else -- blue
				anim_colors = {
					"#E3F2FD",
					"#BBDEFB",
					"#90CAF9",
					"#64B5F6",
					"#42A5F5",
					"#2196F3",
					"#1E88E5",
					"#1976D2",
					"#1565C0",
					"#0D47A1",
				}
			end

			animation.stop_all()
			animation.animation({
				data = {
					{ "waveleft1", efffects.list_color(anim_colors, 6) },
					{ "waveleft2", efffects.list_color(anim_colors, 5) },
					{ "waveleft3", efffects.list_color(anim_colors, 4) },
					{ "waveleft4", efffects.list_color(anim_colors, 3) },
					{ "waveleft5", efffects.list_color(anim_colors, 2) },
				},
				delay = 200,
				interval = 150,
			})

			animation.animation({
				data = {
					{ "waveright1", efffects.list_color(anim_colors, 2) },
					{ "waveright2", efffects.list_color(anim_colors, 3) },
					{ "waveright3", efffects.list_color(anim_colors, 4) },
					{ "waveright4", efffects.list_color(anim_colors, 5) },
					{ "waveright5", efffects.list_color(anim_colors, 6) },
				},
				delay = 200,
				interval = 150,
			})
		end
		-- Đặt sau hàm change_color
		_G.windline_change_color = change_color
		local wave_left = {
			text = function()
				return {
					{ sep.right_filled .. " ", { "wavedefault", "waveleft1" } },
					{ sep.right_filled .. " ", { "waveleft1", "waveleft2" } },
					{ sep.right_filled .. " ", { "waveleft2", "waveleft3" } },
					{ sep.right_filled .. " ", { "waveleft3", "waveleft4" } },
					{ sep.right_filled .. " ", { "waveleft4", "waveleft5" } },
					{ sep.right_filled .. " ", { "waveleft5", "wavedefault" } },
				}
			end,
			click = change_color,
		}

		local wave_right = {
			text = function()
				return {
					{ " " .. sep.left_filled, { "waveright1", "wavedefault" } },
					{ " " .. sep.left_filled, { "waveright2", "waveright1" } },
					{ " " .. sep.left_filled, { "waveright3", "waveright2" } },
					{ " " .. sep.left_filled, { "waveright4", "waveright3" } },
					{ " " .. sep.left_filled, { "waveright5", "waveright4" } },
					{ " " .. sep.left_filled, { "wavedefault", "waveright5" } },
				}
			end,
			click = change_color,
		}

		basic.section_x = {
			hl_colors = colors_mode_rev,
			text = function(_, _, _)
				return {
					-- { sep.left_filled, { "white", "black" } },
					{ " ", state.mode[2] },
					{ b_components.file_encoding(), "" },
					{ " " },
					{ b_components.file_format({ icon = true }), "" },
					{ " " },
				}
			end,
		}

		basic.section_z = {
			hl_colors = colors_mode_rev,
			text = function(_, _, _)
				return {
					{ sep.left, { "white", "black" } },
					-- { " ", state.mode[2] },
					{ b_components.progress_lua },
					{ " " },
					{ b_components.line_col_lua },
				}
			end,
		}

		basic.lsp_diagnos = {
			name = "diagnostic",
			hl_colors = {
				red = { "red", "black" },
				yellow = { "yellow", "black" },
				blue = { "blue", "black" },
			},
			text = function(bufnr)
				if lsp_comps.check_lsp(bufnr) then
					return {
						{ lsp_comps.lsp_error({ format = "  %s", show_zero = true }), "red" },
						{ lsp_comps.lsp_warning({ format = "  %s", show_zero = true }), "yellow" },
						{ lsp_comps.lsp_hint({ format = "  %s", show_zero = true }), "blue" },
					}
				end
				return { " ", "red" }
			end,
		}
		local ctime = {
			text = function()
				local current_time = os.date("%H:%M")
				local symbol = ""
				return "" .. symbol .. " " .. current_time .. " "
			end,
			hl_colors = { "white", "wavedefault" },
		}
		local default = {
			filetypes = { "default" },
			active = {
				basic.vi_mode,
				basic.vi_mode_sep,
				{ " ", "" },
				basic.file_name,
				wave_left,
				basic.divider,
				basic.lsp_diagnos,
				{ " ", { "FilenameBg", "wavedefault" } },
				basic.divider,
				wave_right,
				-- basic.sectin_x,
				basic.section_y,
				basic.section_z,
				ctime,
				-- basic.right,
				-- basic.line_col,
				-- basic.progress,
			},
			inactive = {
				basic.file_name_inactive,
				basic.divider,
				basic.divider,
				-- basic.line_col_inactive,
				-- { "", { "white", "InactiveBg" } },
				-- basic.progress_inactive,
				{ b_components.line_col, hl_list.Inactive },
				{ b_components.progress, hl_list.Inactive },
			},
		}

		windline.setup({
			colors_name = function(colors)
				-- Làm trong suốt nền thanh trạng thái (statusline)
				colors.black = "NONE"
				colors.black_light = "NONE"
				colors.InactiveBg = "NONE"
				colors.ActiveBg = "NONE"

				colors.FilenameFg = colors.white
				colors.FilenameBg = colors.black

				-- Reverting wave backgrounds to actually evaluate as valid colors in the interpolation engine
				-- The engine cannot mathematically interpolate between Hex and 'NONE'.
				-- By letting it calculate against a dark hex, we prevent empty arrows.
				-- The overall transparency will be forced by Neovim's `StatusLine` bg override below.
				colors.wavedefault = "#1e1e1e"
				colors.waveleft1 = colors.wavedefault
				colors.waveleft2 = colors.wavedefault
				colors.waveleft3 = colors.wavedefault
				colors.waveleft4 = colors.wavedefault
				colors.waveleft5 = colors.wavedefault

				colors.waveright1 = colors.wavedefault
				colors.waveright2 = colors.wavedefault
				colors.waveright3 = colors.wavedefault
				colors.waveright4 = colors.wavedefault
				colors.waveright5 = colors.wavedefault

				-- Ghi đè Background gốc của Neovim để đảm bảo trong suốt thực sự
				vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
				vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })

				return colors
			end,
			statuslines = {
				default,
			},
		})

		-- vim.defer_fn(function()
		-- 	change_color()
		-- end, 500)
		-- Thêm đoạn này vào cuối config function
		local get_mode_color = function()
			local mode = vim.api.nvim_get_mode().mode
			if mode:match("^i") then
				return "red"
			end
			if mode:match("^v") or mode:match("^V") or mode == "\22" then
				return "magenta"
			end
			if mode:match("^R") then
				return "cyan"
			end
			if mode:match("^c") then
				return "yellow"
			end
			return "blue"
		end

		local function trigger_anim()
			if vim.bo.filetype == "snacks_dashboard" then
				return
			end
			if _G.WindLine and _G.WindLine.state then
				_G.windline_change_color(get_mode_color())
			else
				-- Retry until Windline state is fully loaded into the global scope
				vim.defer_fn(trigger_anim, 100)
			end
		end

		vim.api.nvim_create_autocmd({ "ModeChanged" }, {
			group = vim.api.nvim_create_augroup("WindlineSyncMode", { clear = true }),
			callback = function()
				trigger_anim()
			end,
		})
		vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("WindlineSyncBuf", { clear = true }),
			callback = function()
				vim.schedule(trigger_anim)
			end,
		})
	end,
}
