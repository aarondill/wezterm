-- local file_exists = require("util.file_exists")
-- print(file_exists("/bin"))
return require("plugin")({
  "theme",
  "update",
  "term",
  "close",
  "window",
  "text",
  "history",
  "ctrl_click",
  "env",
  "toggle-transparency",
  "toggle-ligature",
  "toggle-fullscreen",
  "wayland",
})
