local util = require("util")
local croslist = "/etc/apt/sources.list.d/cros.list"

if util.file_exists(croslist) then return { enable_wayland = false } end
