local wezterm = require("wezterm")
local table = require("table")
local emacs_keys = require('emacs-keys')

local config = {}

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

config.debug_key_events = true

config.font = wezterm.font_with_fallback({
    { family = "Roboto Mono", --[[ scale = 0.8 --]] },
    { family = "FiraCode Nerd Font Mono", --[[ scale = 0.9 --]] }
})
config.font_size = 10
-- config.disable_default_key_bindings = true

config.keys = {
    { key = '.', mods = 'CTRL', action = emacs_keys.SendEmacs("C-.") },
    { key = ',', mods = 'CTRL', action = emacs_keys.SendEmacs("C-,") },
    { key = ' ', mods = 'CTRL', action = emacs_keys.SendEmacs("C-SPC") },
    { key = ' ', mods = 'ALT', action = emacs_keys.SendEmacs("M-SPC"), },
    { key = '/', mods = 'CTRL', action = emacs_keys.SendEmacs("C-/") },
    { key = 'Backspace', mods = 'CTRL', action = emacs_keys.SendEmacs("C-<backspace>") },
    -- { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
    { key = 'F11', action = wezterm.action.ToggleFullScreen },
    -- This needs to be disabled some other way
    -- { key = ' ', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
}

return config
