return function()
  local wezterm = require("wezterm")
  local act = wezterm.action

  return {
    mouse_bindings = {
      -- Change the default click behavior so that it only selects
      -- text and doesn't open hyperlinks
      {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection("PrimarySelection"),
      },

      -- and make CTRL-Click open hyperlinks
      {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
      },

      -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
      {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.Nop,
      },
    },
  }
end
