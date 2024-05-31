local wezterm = require 'wezterm'
local act = wezterm.action

local module = {}

local function SendString(t, str)
    for i = 1, str:len() do
        table.insert(t, 
            act.SendKey { key = str:sub(i,i) }
        )
    end
end

function module.SendEmacs(keyseq_str)
    keyseq = {}
    table.insert(keyseq, act.SendKey { key = "[", mods = 'ALT'})
    SendString(keyseq, "emacs-" .. keyseq_str)
    return act.Multiple(keyseq)
end

return module