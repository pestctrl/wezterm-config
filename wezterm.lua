local wezterm = require("wezterm")
local table = require("table")
local emacs_keys = require('emacs-keys')

local config = {}

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

config.debug_key_events = true

config.font = wezterm.font_with_fallback({
    { family = "Roboto Mono", --[[ scale = 0.8 --]] },
    "Noto Color Emoji",
    { family = "Symbols Nerd Font Mono", scale = 1.1 },
})
-- config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 10
-- config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}

config.colors = {
    background = '#141414',
}

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "Windows Subsystem for Linux",
		args = { "wsl.exe" },
	})
	table.insert(launch_menu, {
		label = "MSYS UCRT64",
		args = { "cmd.exe ", "/k", "C:\\msys64\\msys2_shell.cmd -defterm -here -no-start -shell bash" },
	})
	table.insert(launch_menu, {
		label = "Command Prompt",
		args = { "cmd.exe " },
	})
    config.default_prog = { "cmd.exe" }
end

config.launch_menu = launch_menu

config.key_tables = {
    copy_mode = {
        -- wezterm show-keys --lua --key-table copy_mode
        { key = 'Space', mods = 'CTRL', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
        { key = 'Space', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Block' } },

        { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveDown' },
        { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveUp' },
        { key = 'f', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveRight' },
        { key = 'f', mods = 'ALT', action = wezterm.action.CopyMode 'MoveForwardWord' },
        { key = 'b', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveLeft' },
        { key = 'b', mods = 'ALT', action = wezterm.action.CopyMode 'MoveBackwardWord' },
        { key = 'g', mods = 'CTRL', action = wezterm.action.CopyMode 'Close' },

        { key = 'a', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveToStartOfLine' },
        { key = 'e', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveToEndOfLineContent' },

        -- { key = 'w', mods = 'ALT', action = wezterm.action.CopyTo 'Clipboard' },
        { key = 'w', mods = 'ALT', action = wezterm.action.Multiple { { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
    }
}

config.keys = {
    -- wezterm show-keys --lua
    -- Wezterm Features
    { key = 'Space', mods = 'ALT', action = wezterm.action.SendKey { key = 'Space', mods = 'ALT' } },

    { key = 'x', mods = 'CTRL|ALT', action = wezterm.action.DisableDefaultAssignment },
    { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
    
    -- Tab Launcher
    { key = '0', mods = 'CTRL|ALT', action = wezterm.action.ShowLauncher },
    { key = '1', mods = 'CTRL|ALT', action = wezterm.action.ActivateTabRelative(-1) },
    { key = '2', mods = 'CTRL|ALT', action = wezterm.action.ActivateTabRelative(1) },
    { key = '7', mods = 'CTRL|ALT', action = wezterm.action.DecreaseFontSize },
    { key = '8', mods = 'CTRL|ALT', action = wezterm.action.IncreaseFontSize },
    { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
    { key = 'F11', action = wezterm.action.ToggleFullScreen },

    -- Emacs Idioms
    { key = 'Home', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL'} },
    { key = 'End', action = wezterm.action.SendKey { key = 'e', mods = 'CTRL'} },

    -- Terminal key compatibility
    { key = '.', mods = 'CTRL', action = emacs_keys.SendEmacs("C-.") },
    { key = ',', mods = 'CTRL', action = emacs_keys.SendEmacs("C-,") },
    { key = ' ', mods = 'CTRL', action = emacs_keys.SendEmacs("C-SPC") },
    { key = ' ', mods = 'ALT', action = emacs_keys.SendEmacs("M-SPC"), },
    { key = '/', mods = 'CTRL', action = emacs_keys.SendEmacs("C-/") },
    { key = 'Backspace', mods = 'CTRL', action = emacs_keys.SendEmacs("C-<backspace>") },
    { key = 'Enter', mods = 'CTRL', action = emacs_keys.SendEmacs("C-<return>"), },
    { key = 'Enter', mods = 'ALT|SHIFT', action = emacs_keys.SendEmacs("M-S-<return>"), },
    { key = 'Enter', mods = 'CTRL|SHIFT', action = emacs_keys.SendEmacs("C-S-<return>"), },
    -- This needs to be disabled some other way
    -- { key = ' ', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
}

return config
