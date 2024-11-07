-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configurations
local config = wezterm.config_builder()

config.font_size = 16
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

return config
