-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Define the color schemes
config.color_schemes = {
  ['Aki'] = {
    -- Basic colors
    ansi = {
      '#2C2D39',  -- Black
      '#CA6D73',  -- Red
      '#B4C7A7',  -- Green
      '#E6C193',  -- Yellow
      '#7EB3C9',  -- Blue (swapped with cyan)
      '#AD8DBD',  -- Magenta
      '#939DBD',  -- Cyan (swapped with blue)
      '#D1CEC9',  -- White
    },
    background = '#101317',
    brights = {
      '#454756',  -- Bright Black
      '#CA6D73',  -- Bright Red
      '#B4C7A7',  -- Bright Green
      '#E6C193',  -- Bright Yellow
      '#7BC2DF',  -- Bright Blue (swapped with cyan)
      '#AD8DBD',  -- Bright Magenta
      '#939DBD',  -- Bright Cyan (swapped with blue)
      '#E4E1DD',  -- Bright White
    },
    compose_cursor = '#CA6D73',  -- Using URL color for this
    cursor_bg = '#E4E1DD',  -- Using foreground color as default
    cursor_border = '#E4E1DD',  -- Using foreground color as default
    cursor_fg = '#101317',  -- Using background color as default
    foreground = '#E4E1DD',
    scrollbar_thumb = '#454756',  -- Using bright black
    selection_bg = '#CA6D73',
    selection_fg = '#22232E',
    split = '#939DBD',  -- Using active_border_color
    visual_bell = '#E6C193',  -- Using bell_border_color
    
    -- Indexed colors
    indexed = {
      [16] = '#E6C193',  -- Using yellow for indexed 16
      [17] = '#E4E1DD',  -- Using foreground for indexed 17
    },
    
    -- Tab bar colors
    tab_bar = {
      background = '#22232E',
      inactive_tab_edge = '#101317',
      
      -- Active tab
      active_tab = {
        bg_color = '#AD8DBD',
        fg_color = '#22232E',
        intensity = 'Normal',
        italic = false,
        strikethrough = false,
        underline = 'None',
      },
      
      -- Inactive tab
      inactive_tab = {
        bg_color = '#101317',
        fg_color = '#E4E1DD',
        intensity = 'Normal',
        italic = false,
        strikethrough = false,
        underline = 'None',
      },
      
      -- Inactive tab hover
      inactive_tab_hover = {
        bg_color = '#2C2D39',
        fg_color = '#E4E1DD',
        intensity = 'Normal',
        italic = false,
        strikethrough = false,
        underline = 'None',
      },
      
      -- New tab
      new_tab = {
        bg_color = '#22232E',
        fg_color = '#E4E1DD',
        intensity = 'Normal',
        italic = false,
        strikethrough = false,
        underline = 'None',
      },
      
      -- New tab hover
      new_tab_hover = {
        bg_color = '#454756',
        fg_color = '#E4E1DD',
        intensity = 'Normal',
        italic = false,
        strikethrough = false,
        underline = 'None',
      },
    },
  },
}

-- Set Aki as the default color scheme
config.color_scheme = 'Aki'

-- Hide the tab bar
config.enable_tab_bar = false

-- Hide the window title bar
config.window_decorations = "NONE"

-- If you want to enable the tab bar only when there are multiple tabs
-- config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
