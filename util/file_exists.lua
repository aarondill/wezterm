local wezterm = require("wezterm")
local function escape(file) ---@param file string
  return file:gsub("[{*\\?]", "\\%1")
end
---checks if a file exists on the filesystem
---Abuses wezterm.glob.
---@param name string? path to the file (relative to CWD)
---@return boolean exists
local function file_exists(name)
  if not name then return false end
  local res = wezterm.glob(escape(name)) ---@type string[]
  return res[1] == name
end

return file_exists
