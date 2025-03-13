return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"lua",
				"bash",
				"javascript",
				"jsdoc",
				"typescript",
				"rust",
				"php",
				"php_only",
				"phpdoc",
				"nginx",
				"json",
				"html",
				"gitignore",
				"gitcommit",
				"gitattributes",
				"git_rebase",
				"git_config",
				"dockerfile",
				"css",
				"diff",
				"blade",
			},
			sync_install = false,
			auto_install = true,
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "blade" },
			},
			indent = { enable = true },
		},
		config = function(_, config)
			---@class ParserInfo[]
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			-- parser_config.blade = {
			-- 	install_info = {
			-- 		url = "https://github.com/EmranMR/tree-sitter-blade",
			-- 		files = { "src/parser.c" },
			-- 		branch = "main",
			-- 	},
			-- 	filetype = "blade",
			-- }
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					-- url = "https://github.com/deanrumsby/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			}
			vim.filetype.add({
				pattern = {
					[".*%.blade%.php"] = "blade",
				},
			})
			require("nvim-treesitter.configs").setup(config)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
		config = function()
			vim.api.nvim_set_hl(0, "TreesitterContext", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
		end,
	},
}
