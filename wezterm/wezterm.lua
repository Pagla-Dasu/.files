local wezterm = require("wezterm")
-- local gpus = wezterm.gui.enumerate_gpus()

return {
	-- webgpu_preferred_adapter = gpus[1],
	audible_bell = "Disabled",
	color_scheme = "Tokyo Night Moon",
	-- color_scheme = "Catppuccin Macchiato (Gogh)",
	font = wezterm.font_with_fallback({
		{
			family = "Victor Mono",
			harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		},
		"Victor Mono Nerd Font",
		{
			family = "GeistMono Nerd Font",
			harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		},
	}),
	enable_tab_bar = false,
	font_size = 18.0,
	macos_window_background_blur = 30,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	max_fps = 240,
	native_macos_fullscreen_mode = true,
	front_end = "WebGpu",
	-- initial_cols = 140,
	-- initial_rows = 40,
	hyperlink_rules = {
		-- Matches: a URL in parens: (URL)
		{
			regex = "\\((\\w+://\\S+)\\)",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in brackets: [URL]
		{
			regex = "\\[(\\w+://\\S+)\\]",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in curly braces: {URL}
		{
			regex = "\\{(\\w+://\\S+)\\}",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in angle brackets: <URL>
		{
			regex = "<(\\w+://\\S+)>",
			format = "$1",
			highlight = 1,
		},
		-- Then handle URLs not wrapped in brackets
		{
			regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
			format = "$0",
		},
		-- implicit mailto link
		{
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},
	},
}
