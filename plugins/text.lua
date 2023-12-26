return function()
  local wezterm = require("wezterm")
  local use_regular = "20230712-072601-f4abf8fd" -- Last *known* good commit for Regular font (IMO). Thin font affects font brightness before this.
  local font_weight = wezterm.version <= use_regular and "Regular" or "Thin"
  return {
    -- *THIS* is a word. (default)
    selection_word_boundary = " \t\n{}[]()\"'`",

    -- Don't lmk if i'm missing some stuff
    warn_about_missing_glyphs = false,

    -- Pasting compatibility with windows. (default - true, equivalent to CarriageReturnAndLineFeed)
    canonicalize_pasted_newlines = "CarriageReturnAndLineFeed",
    -- Save me some work! (default "Spaces Only")
    quote_dropped_files = "Posix",

    -- I see you! Show me more of it pls (default 12.0)
    font_size = 8.5,
    -- You too! (default 14.0)
    command_palette_font_size = 9.5,

    font = wezterm.font_with_fallback({
      "JetBrains Mono", -- <built-in>, BuiltIn
      -- /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf, FontConfig
      -- Assumed to have Emoji Presentation
      -- Pixel sizes: [128]
      "Noto Color Emoji",
      "Symbols Nerd Font Mono", -- <built-in>, BuiltIn
    }, { weight = font_weight }),
    freetype_load_flags = "NO_HINTING", -- Fix a ton of rendering issues
  }
end
