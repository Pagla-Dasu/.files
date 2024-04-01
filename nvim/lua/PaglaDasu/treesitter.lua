return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.1",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"css",
				"html",
				"gitignore",
				"dockerfile",
				"graphql",
				"prisma",
				"http",
				"json",
				"scss",
				"sql",
				"vim",
				"lua",
				"python",
				"tsx",
				"yaml",
				"jsdoc",
				"bash",
			},
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
			autotag = {
				enable = true,
			},
		},
	},
}
