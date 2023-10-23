-- Sets TERM environment if necessary info is present. Does NOT install it
local file_exists = require("util.file_exists")

local root_terminfo = "/lib/terminfo/w/wezterm"
local local_terminfo = os.getenv("HOME") and (os.getenv("HOME") .. "/.terminfo/w/wezterm")
if file_exists(root_terminfo) or file_exists(local_terminfo) then
  -- set TERM to 'wezterm' only if terminfo is installed
  return { term = "wezterm" }
end
