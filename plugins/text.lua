return function()
  local wezterm = require("wezterm")
  return {
    -- *THIS* is a word. (default)
    selection_word_boundary = " \t\n{}[]()\"'`",

    -- Lmk if i'm missing some stuff (default)
    warn_about_missing_glyphs = true,

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
    }),
  }
end
