-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_tab_bar = false

config.window_decorations = "NONE"

config.font = wezterm.font('Rec Mono Casual');

config.font_size = 12.0


config.color_schemes = {
	["Aki"] = {
		-- Basic colors
		ansi = {
			"#2C2D39", 
			"#CA6D73", 
			"#B4C7A7", 
			"#E6C193", 
			"#7EB3C9", 
			"#AD8DBD", 
			"#939DBD", 
			"#D1CEC9", 
		},
		background = "#101317",
		brights = {
			"#454756", 
			"#CA6D73", 
			"#B4C7A7", 
			"#E6C193", 
			"#7BC2DF", 
			"#AD8DBD", 
			"#939DBD", 
			"#E4E1DD", 
		},
		compose_cursor = "#CA6D73", 
		cursor_bg = "#E4E1DD", 
		cursor_border = "#E4E1DD", 
		cursor_fg = "#101317", 
		foreground = "#E4E1DD",
		scrollbar_thumb = "#454756", 
		selection_bg = "#CA6D73",
		selection_fg = "#22232E",
		split = "#939DBD", 
		visual_bell = "#E6C193", 

		indexed = {
			[16] = "#E6C193", 
			[17] = "#E4E1DD", 
		},

		tab_bar = {
			background = "#22232E",
			inactive_tab_edge = "#101317",

			active_tab = {
				bg_color = "#AD8DBD",
				fg_color = "#22232E",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			inactive_tab = {
				bg_color = "#101317",
				fg_color = "#E4E1DD",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			inactive_tab_hover = {
				bg_color = "#2C2D39",
				fg_color = "#E4E1DD",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			new_tab = {
				bg_color = "#22232E",
				fg_color = "#E4E1DD",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			new_tab_hover = {
				bg_color = "#454756",
				fg_color = "#E4E1DD",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
		},
	},
}

config.color_scheme = "Aki"

return config
