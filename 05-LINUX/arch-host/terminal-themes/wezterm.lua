-- CP2077 WezTerm color theme
-- Merged from Cyberpunk-Neon (Roboron3042) + CP2077 design tokens
-- Usage in wezterm.lua:
--   local cp2077 = require("path.to.this.file")
--   config.color_scheme_dirs = { ... }
--   config.color_scheme = "CP2077"
-- Or register inline:
--   config.colors = require("path.to.cp2077-wezterm").colors

local M = {}

M.colors = {
  foreground    = "#00FFFF",
  background    = "#000b1e",
  cursor_bg     = "#FCEE0C",
  cursor_border = "#FCEE0C",
  cursor_fg     = "#000000",
  selection_bg  = "#711c91",
  selection_fg  = "#00FFFF",

  -- Tab bar
  tab_bar = {
    background          = "#000b1e",
    active_tab = {
      bg_color  = "#FCEE0C",
      fg_color  = "#000000",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color  = "#0A0A0A",
      fg_color  = "#555555",
    },
    inactive_tab_hover = {
      bg_color  = "#1A1A0A",
      fg_color  = "#AAAAAA",
    },
    new_tab = {
      bg_color  = "#000b1e",
      fg_color  = "#555555",
    },
  },

  ansi = {
    "#0A0A0A",  -- black
    "#FF003C",  -- red    — danger / flatline
    "#00FF9F",  -- green  — success / health
    "#FCEE0C",  -- yellow — primary / corp-ID
    "#133e7c",  -- blue
    "#711c91",  -- magenta — netrunner purple
    "#00FFFF",  -- cyan   — secondary / uplink
    "#AAAAAA",  -- white
  },
  brights = {
    "#2A2A2A",  -- bright black
    "#FF003C",  -- bright red
    "#00FF9F",  -- bright green
    "#FCEE0C",  -- bright yellow
    "#1c61c2",  -- bright blue
    "#ea00d9",  -- bright magenta
    "#00FFFF",  -- bright cyan
    "#C0C0C0",  -- bright white
  },
}

-- For use as a named color scheme (copy to wezterm color scheme dir):
M.scheme = {
  name   = "CP2077",
  colors = M.colors,
}

return M
