-- Licence: MIT-0 (https://github.com/aws/mit-0)

-- WezTerm Terminal Emulator config file.

-- NOTE: Microsoft Windows only

-- Required utility: Required utility: Clink (Powerful Bash-style
--                                            command line editing for cmd.exe)
-- https://mridgers.github.io/clink/

-- Before using, rename this file to "wezterm.lua".
-- This file should be placed in the directory %PROGRAMFILES%\WezTerm
-- where "wezterm.exe" is located.

-- You may have to edit this file with admin privilege since
-- it has to be placed in a system directory, "%PROGRAMFILES%\WezTerm".
-- Open Notepad++ with admin privilege (R-click on the
-- Start menu -> Notepad++ -> Run as administrator), then open this file
-- "wezterm.lua".

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
-- Tile WezTerm Window to the Right: MOD+RightArrow
-- Resize Upwards (Maximise, etc.): MOD+UpArrow
-- Resize Downwards (Minimise, etc.): MOD+DownArrow
-- Navigate to the Left-Split Pane: MOD+SHIFT+h
-- Navigate to the Right-Split Pane: MOD+SHIFT+l
-- Navigate to the Top-Split Pane: MOD+SHIFT+k (s"K"y)
-- Navigate to the Bottom-Split Pane: MOD+SHIFT+j ("J" as an umbrella, being used as a parachute)



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


wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover)
    local tab_is_toolbox = (tab.active_pane.user_vars.in_toolbox or "false") == "true";
    local tab_is_hover = hover;
    local tab_is_active = tab.is_active;

    if tab_is_active then
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

    }


end)


local empty = ""

return {
    font = wezterm.font_with_fallback({
         {
            family="Iosevka Term SS04",
            harfbuzz_features={"calt=0", "clig=0", "liga=0"},
         },
         "Lucida Console",
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
    -- color_scheme = "Galaxy",
    -- color_scheme = "N0tch2k",
    -- color_scheme = "Desert",
    -- color_scheme = "Ubuntu",
    -- color_scheme = "UltraViolent",
    -- color_scheme = "UltraDark",
    color_scheme = "UnderTheSea",
    -- color_scheme = "Grape",
    -- color_scheme = "The Hulk",
    -- color_scheme = "Zenburn",
    -- color_scheme = "Seafoam Pastel",
    -- color_scheme = "Sublette",
    -- color_scheme = "Modus-Operandi",

    font = wezterm.font("Lucida Console"),
    font_size = 10.0,
    font_antialias = 'Subpixel',
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
    term = "wezterm",
    default_cursor_style = "BlinkingBar",
    -- default_cursor_style = "SteadyBar",

    tab_max_width = tab_max_width,
    -- both are intentionally left empty as we use the title bar function
    tab_bar_style = {
        active_tab_left = empty,
        active_tab_right = empty,
        inactive_tab_left = empty,
        inactive_tab_right = empty,
        inactive_tab_hover_left = empty,
        inactive_tab_hover_right = empty,
    },
    colors = {
        tab_bar = {},
    },

   skip_close_confirmation_for_processes_named = {
      'bash',
      'fish',
      'tmux',
   },

   ssh_backend = "Ssh2",

    -- window_background_image = "Q:\\wallpaper\\MaterialDesign\\Material-Design-Dark-HD-Wallpaper-23175.jpg",
    -- window_background_opacity = 0.9,

   -- line_height = 0.9,
   initial_rows = 34,
   initial_cols = 125,

   default_prog = { 'cmd' },
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
        {key="RightArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Right"}},
        -- Resize Upwards (Maximise, etc.): MOD+UpArrow
        {key="UpArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Up"}},
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

        -- No effect on MS Windows
        -- {key = "z", mods="SUPER", action="TogglePaneZoomState"},

        -- Paste: Middle-click/CTRL+SHIFT+v/MOD+v
        {key="v", mods="SUPER", action=wezterm.action.PasteFrom("Clipboard")},
        -- Copy: Right-click/CTRL+SHIFT+c/MOD+c
        {key="c", mods="SUPER", action=wezterm.action.CopyTo("Clipboard")},
    }
}

