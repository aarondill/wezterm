local file_exists = require("util.file_exists")
local croslist = "/etc/apt/sources.list.d/cros.list"

if not file_exists(croslist) then return nil end
--- Wayland is broken in chromeos cros VM
return { enable_wayland = false }
