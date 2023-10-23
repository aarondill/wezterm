return function()
  local toggle = require("util.toggle")
  local wezterm = require("wezterm")

  wezterm.on("toggle-opacity", function(window)
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_opacity = toggle(overrides.window_background_opacity, 1)
    return window:set_config_overrides(overrides)
  end)

  return require("util.define_key")({
    key = "B",
    mods = "CTRL",
    action = wezterm.action.EmitEvent("toggle-opacity"),
  })
end
