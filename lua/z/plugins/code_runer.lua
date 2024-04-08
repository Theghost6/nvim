return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
      mode = 'float',
			float = {
				close_key = "<ESC>",
				-- Window border (see ':h nvim_open_win')
				border = "single",

				-- Num from `0 - 1` for measurements
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,

				-- Highlight group for floating window/border (see ':h winhl')
				border_hl = "Normal",
				float_hl = "Normal",

				-- Transparency (see ':h winblend')
				blend = 0,
			},
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				python = "python3 -u",
				typescript = "deno run",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ $fileName -o $fileNameWithoutExt &&",
					"./$fileNameWithoutExt",
				},
			},
		})
	end,
}
