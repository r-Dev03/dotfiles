-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.font = wezterm.font("Rec Mono Casual")
config.font_size = 13.0

config.color_schemes = {
	["Aki"] = {
		-- Basic colors - matching vague.nvim's muted palette
		ansi = {
			"#505164", -- black (line)
			"#b48484", -- red (error/parameter)
			"#b4c7a7", -- green (string) - muted teal-green
			"#C3AD8B", -- yellow (warning/delta)
			"#797ea3", -- blue (keyword/builtin) - desaturated
			"#ad8dbd", -- magenta (func/number) - muted purple
			"#8f8fb4", -- cyan (operator) - soft blue-gray
			"#D1CEC9", -- white (fg)
		},
		background = "#101317", -- bg
		brights = {
			"#505164", -- black
			"#b48484", -- red
			"#b4c7a7", -- green
			"#C3AD8B", -- yellow
			"#797ea3", -- blue
			"#ad8dbd", -- magenta
			"#8f8fb4", -- cyan
			"#D1CEC9", -- white
		},
		compose_cursor = "#ad8dbd",
		cursor_bg = "#D1CEC9",
		cursor_border = "#D1CEC9",
		cursor_fg = "#101317",
		foreground = "#D1CEC9", -- fg
		scrollbar_thumb = "#505164", -- comment
		selection_bg = "#1c1c24", -- visual
		selection_fg = "#D1CEC9",
		split = "#505164",
		visual_bell = "#C3AD8B",
		indexed = {
			[16] = "#C3AD8B",
			[17] = "#D1CEC9",
		},
	},
}
config.color_scheme = "Aki"
return config
