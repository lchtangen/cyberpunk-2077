-- Cyberpunk 2077 — WezTerm Color Scheme
-- Apply: add `color_scheme = "Cyberpunk2077"` to wezterm.lua, or use
--   config.color_schemes = require("cp2077-wezterm").schemes
-- then config.color_scheme = "Cyberpunk2077"

local M = {}

M.schemes = {
  ["Cyberpunk2077"] = {
    foreground = "#fcee0c",
    background = "#0a0a0a",

    cursor_bg     = "#00ffff",
    cursor_fg     = "#0a0a0a",
    cursor_border = "#00ffff",

    selection_fg = "#fcee0c",
    selection_bg = "#2a2a2a",

    scrollbar_thumb = "#2a2a2a",
    split           = "#2a2a2a",

    ansi = {
      "#0a0a0a",  -- black   (0)
      "#ff003c",  -- red     (1)
      "#00ff9f",  -- green   (2)
      "#fcee0c",  -- yellow  (3)
      "#0050ff",  -- blue    (4)
      "#ff6b35",  -- magenta (5)
      "#00ffff",  -- cyan    (6)
      "#cccccc",  -- white   (7)
    },

    brights = {
      "#2a2a2a",  -- bright black   (8)
      "#ff003c",  -- bright red     (9)
      "#00ff9f",  -- bright green  (10)
      "#fcee0c",  -- bright yellow (11)
      "#4d9fff",  -- bright blue   (12)
      "#ff6b35",  -- bright magenta(13)
      "#00ffff",  -- bright cyan   (14)
      "#ffffff",  -- bright white  (15)
    },

    indexed = {},

    compose_cursor = "#ff6b35",

    copy_mode_active_highlight_bg   = { Color = "#fcee0c" },
    copy_mode_active_highlight_fg   = { Color = "#0a0a0a" },
    copy_mode_inactive_highlight_bg = { Color = "#2a2a2a" },
    copy_mode_inactive_highlight_fg = { Color = "#888888" },

    quick_select_label_bg   = { Color = "#fcee0c" },
    quick_select_label_fg   = { Color = "#0a0a0a" },
    quick_select_match_bg   = { Color = "#2a2a2a" },
    quick_select_match_fg   = { Color = "#00ffff" },

    tab_bar = {
      background         = "#0a0a0a",
      active_tab = {
        bg_color   = "#fcee0c",
        fg_color   = "#0a0a0a",
        intensity  = "Bold",
        underline  = "None",
        italic     = false,
        strikethrough = false,
      },
      inactive_tab = {
        bg_color = "#2a2a2a",
        fg_color = "#888888",
      },
      inactive_tab_hover = {
        bg_color = "#2a2a2a",
        fg_color = "#fcee0c",
      },
      new_tab = {
        bg_color = "#0a0a0a",
        fg_color = "#888888",
      },
      new_tab_hover = {
        bg_color = "#00ffff",
        fg_color = "#0a0a0a",
      },
    },
  },
}

return M
