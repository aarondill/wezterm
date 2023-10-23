local toggle = require("util.toggle")
local wezterm = require("wezterm")

wezterm.on("toggle-ligature", function(window)
  local overrides = window:get_config_overrides() or {}
  overrides.harfbuzz_features = toggle(overrides.harfbuzz_features, { "calt=0", "clig=0", "liga=0" })
  window:set_config_overrides(overrides)
end)

return require("util.define_key")({
  key = "E",
  mods = "CTRL",
  action = wezterm.action.EmitEvent("toggle-ligature"),
})
