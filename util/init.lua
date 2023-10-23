local path = ...
path = path:find("%.init$") and path:match("(.*)%.init") or path
local function notify(title, message, timeout)
  local w = require("wezterm").gui.gui_windows()[1]
  return w:toast_notification(title or "wezterm", message or "No Message Provided", nil, timeout)
end
return setmetatable({}, {
  __index = function(_, key)
    local m = ("%s.%s"):format(path, key)
    local ok, mod = pcall(require, m)
    if ok then return mod end
    notify("Wezterm - Util.lua", ("Module '%s' doesn't exist"):format(m))
    return nil
  end,
})
