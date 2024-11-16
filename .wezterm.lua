-- Pull in the wezterm API
local wezterm = require("wezterm")

return {
    font_size = 16,
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    use_ime = false,
    color_scheme = "Catppuccin Mocha",
    keys = {
        {
            key = 'd',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateCopyMode
        },
        {
            key = "-",
            mods = "CTRL",
            action = wezterm.action {
                SendString = 'cd "$(find $HOME/Projects/ -type d -maxdepth 2 | fzf)" && nvim -o .\n'
            }
        },
    },
    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CTRL',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
}
