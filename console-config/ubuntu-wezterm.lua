-- Licence: MIT-0 (https://github.com/aws/mit-0)

-- WezTerm Terminal Emulator config file.

--- Updated config for wezterm 20230320-124340-559cb7b0
--- https://wezfurlong.org/wezterm/changelog.html#20220319-142410-0fcdea07

-- NOTE: *-Ubuntu Linux only.

-- Before using, rename this file to "wezterm.lua".
-- This file should be placed in the directory $HOME/.config/wezterm.

-- mkdir $HOME/.config/wezterm
-- touch $HOME/.config/wezterm/wezterm.lua
-- thunar $HOME/.config/wezterm
-- mousepad $HOME/.config/wezterm/wezterm.lua
-- Paste the contents of this file to $HOME/.config/wezterm/wezterm.lua,
-- and then edit that file.

-- Mostly based on:
-- https://github.com/wodadehencou/wezterm-config
-- Partly based on:
-- https://github.com/soundless/wezterm-config/blob/main/wezterm.lua
-- https://wezfurlong.org/wezterm/config/lua/config/
-- https://github.com/codito/configs-win/blob/master/.wezterm.lua

-- Keybindings:
-- MOD Key: WINDOWS
-- Paste: Middle-click/CTRL+SHIFT+v/MOD+v
-- Copy: Right-click/CTRL+SHIFT+c/MOD+c

-- Vim-like navigation:
-- Split a TAB Horizontally: MOD+SHIFT+u
-- Split a TAB Vertically: MOD+SHIFT+d
-- Tile WezTerm Window to the Left: MOD+LeftArrow

-- *** Press MOD+LeftArrow twice for tiling to the right.

-- Resize Downwards (Minimise, etc.): MOD+DownArrow

-- *** Press (Maximise, etc.): MOD+DownArrow twice for Resizing Upwards again.

-- Navigate to the Left-Split Pane: MOD+SHIFT+h
-- Navigate to the Right-Split Pane: MOD+SHIFT+l
-- Navigate to the Top-Split Pane: MOD+SHIFT+k (s"K"y)
-- Navigate to the Bottom-Split Pane: MOD+SHIFT+j ("J" as an umbrella, being used as a parachute)

-- Maximises the current split. MOD+z


local wezterm = require 'wezterm';
-- The powerline </> symbol
local mux = wezterm.mux

local LEFT_ARROW = utf8.char(0xe0b3);
local SOLID_LEFT_ARROW = utf8.char(0xe0b2);
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0);


local color_tabbar_background = "#0d001a"
-- background, forground, intensity, underline
local color_tab_inactive={"#3c1361", "#808080", "Bold", "None"};
local color_tab_hoover={"#ffff00", "#333300", "Bold", "Single"};
local color_tab_active={"#336600", "#cccccc", "Bold", "None"};
-- meh: chars and width are only broadly related...
local tab_max_width = 50
local tab_max_chars = 30


wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local tab_is_toolbox = (tab.active_pane.user_vars.in_toolbox or "false") == "true";
    local tab_is_hover = hover;
    local tab_is_active = tab.is_active;
    --- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
    if tab.is_active then
        return {
          { Background = { Color = 'darkgreen' } },
          { Text = ' ' .. tab.active_pane.title .. ' ' },
        }
    elseif tab_is_active then
        c = color_tab_active;
    elseif tab_is_hover then
        c=color_tab_hoover;
    else
        c=color_tab_inactive;
    end

    bg=c[1]
    fg=c[2]
    b=c[3]
    u=c[4]

    title = tab.active_pane.title;
    -- we can only display some predefined chars at maximum and have to add
    -- the numbering ("xx: ", 4 chars) and maybe a dot + space (3 chars))
    available_chars = tab_max_chars - 4 - 3;
    title_chars = string.len(title)
    if title_chars > available_chars then
        title = "…" .. string.sub(title, title_chars - available_chars) ;
    end

    if tab_is_toolbox then
        title = "🔴 " .. title
    end

    if #tabs > 1 then
        title = string.format("%d: %s", tab.tab_index + 1, title);
    end

    return {
        {Background={Color=color_tabbar_background}},
        {Foreground={Color=bg}},
        {Text=SOLID_LEFT_ARROW},
        {Background={Color=bg}},
        {Foreground={Color=fg}},
        {Text=" "},
        {Attribute={Underline=u}},
        {Attribute={Intensity=b}},
        {Text=title},
        {Attribute={Intensity="Normal"}},
        {Attribute={Underline="None"}},
        {Text=" "},
        {Background={Color=color_tabbar_background}},
        {Foreground={Color=bg}},
        {Text=SOLID_RIGHT_ARROW},
        {tab.active_pane.title}, --- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html

    }


end)


local empty = ""

return {
    font = wezterm.font_with_fallback({
         {
            family="Iosevka Term SS04",
            harfbuzz_features={"calt=0", "clig=0", "liga=0"},
         },
         "DejaVu Sans Mono",
    }),

    window_padding = {
                       left = 5,
                       right = 15,
                       top = 0,
                       bottom = 5
    },


    -- color_scheme = "IC_Orange_PPL",
    -- color_scheme = "jubi",
    -- color_scheme = "lovelace",
    -- color_scheme = "Material",
    -- color_scheme = "OceanicMaterial",
    -- color_scheme = "Popping and Locking",
    -- color_scheme = "Espresso",
    -- color_scheme = "Fideloper",
    -- color_scheme = "ToyChest",
    color_scheme = "Galaxy",
    -- color_scheme = "N0tch2k",
    -- color_scheme = "Desert",
    -- color_scheme = "Ubuntu",
    -- color_scheme = "UltraViolent",
    -- color_scheme = "UltraDark",
    -- color_scheme = "UnderTheSea",
    -- color_scheme = "Grape",
    -- color_scheme = "The Hulk",
    -- color_scheme = "Zenburn",
    -- color_scheme = "Seafoam Pastel",
    -- color_scheme = "Sublette",
    -- color_scheme = "Modus-Operandi",

    font = wezterm.font("DejaVu Sans Mono"),
    font_size = 10.0,
    -- font_antialias = 'Subpixel',
    --- https://wezfurlong.org/wezterm/changelog.html#20210314-114017-04b7cedd
    freetype_load_target = "Light",
    freetype_load_flags = "NO_HINTING",
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    -- font_rules = {
    --  {

    --  },
    -- },

    -- How many lines of scrollback you want to retain per tab
    scrollback_lines = 1000000,

    -- Enable the scrollbar.
    -- It will occupy the right window padding space.
    -- If right padding is set to 0 then it will be increased
    -- to a single cell width
    enable_scroll_bar = true,

    enable_tab_bar = true,
    use_fancy_tab_bar = true,
    -- If you want to access the Fish shell
    -- from WezTerm, do not set WezTerm as the default terminal.

    -- -- warning: Could not set up terminal.
    -- -- warning: TERM environment variable set to 'wezterm'.
    -- -- warning: Check that this terminal type is supported on this system.
    -- -- warning: Using fallback terminal type 'ansi'.

    -- term = "wezterm",

    --- https://wezfurlong.org/wezterm/config/lua/config/default_cursor_style.html
    --- Acceptable values are SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.
    default_cursor_style = "BlinkingBar",
    -- default_cursor_style = "SteadyBar",
    -- https://wezfurlong.org/wezterm/config/lua/config/default_cursor_style.html

    -- Helix Editor fix: Cursor not changing in Helix under WezTerm.
    cursor_thickness = "0.1cell",
    -- https://wezfurlong.org/wezterm/config/lua/config/cursor_thickness.html

    -- Helix Editor fix: Cursor not changing in Helix under WezTerm.
    -- allow_win32_input_mode = true,
    -- https://wezfurlong.org/wezterm/config/lua/config/allow_win32_input_mode.html

    tab_max_width = tab_max_width,
    -- both are intentionally left empty as we use the title bar function
    

    colors = {
        tab_bar = {},
    },

   skip_close_confirmation_for_processes_named = {
      'bash',
      'fish',
      'tmux',
   },

   ssh_backend = "Ssh2",

    -- window_background_image = "/home/YOUR_USERNAME/Pictures/Wallpapers-Final-Collection/Desert Blue.jpg",
    -- window_background_opacity = 0.9,

   -- line_height = 0.9,
   initial_rows = 34,
   initial_cols = 125,

   default_prog = { 'bash' },
   -- default_prog = { 'vim' },
   launch_menu = {},

   cursor_blink_rate = 300,
   underline_thickness = "5",

    -- Keybindings
    keys = {
        -- Split a TAB Horizontally: MOD+SHIFT+u
        {key="u", mods="SUPER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        -- Split a TAB Vertically: MOD+SHIFT+d
        {key="d", mods="SUPER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        -- Tile WezTerm Window to the Left: MOD+LeftArrow
        {key="LeftArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Left"}},

        -- Tile WezTerm Window to the Right: MOD+RightArrow
        -- *** Conflicts with my iBus settings. Instead, press
        -- MOD+LeftArrow twice.
        -- -- {key="RightArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Right"}},

        -- *** Does not work.Instead, press
        -- MOD+DownArrow twice.
        -- Resize Upwards (Maximise, etc.): MOD+UpArrow
        -- -- {key="UpArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Up"}},

        -- Resize Downwards (Minimise, etc.): MOD+DownArrow
        {key="DownArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Down"}},
        -- Navigate to the Left-Split Pane: MOD+SHIFT+h
        {key="h", mods="SUPER|SHIFT", action=wezterm.action{ActivatePaneDirection="Left"}},
        -- Navigate to the Right-Split Pane: MOD+SHIFT+l
        {key="l", mods="SUPER|SHIFT", action=wezterm.action{ActivatePaneDirection="Right"}},
        -- Navigate to the Top-Split Pane: MOD+SHIFT+k (s"K"y)
        {key="k", mods="SUPER|SHIFT", action=wezterm.action{ActivatePaneDirection="Up"}},
        -- Navigate to the Bottom-Split Pane: MOD+SHIFT+j ("J" as an umbrella, being used as a parachute)
        {key="j", mods="SUPER|SHIFT", action=wezterm.action{ActivatePaneDirection="Down"}},

        -- Maximises the current split. MOD+z
        {key = "z", mods="SUPER", action="TogglePaneZoomState"},

        -- Paste: Middle-click/CTRL+SHIFT+v/MOD+v
        {key="v", mods="SUPER", action=wezterm.action.PasteFrom("Clipboard")},
        -- Copy: Right-click/CTRL+SHIFT+c/MOD+c
        {key="c", mods="SUPER", action=wezterm.action.CopyTo("Clipboard")},
    }
}

