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
                "diff"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--   If you are experiencing weird indenting issues, add the language to
				--   the list of additional_vim_regex_highlighting and disabled languages for indent.
				-- additional_vim_regex_highlighting = { "ruby" },
				use_languagetree = false,
				additional_vim_regex_highlighting = false,
				disable = function(_, bufnr)
					local buf_name = vim.api.nvim_buf_get_name(bufnr)
					local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
					return file_size > 256 * 1024
				end,
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, config)
			require("nvim-treesitter.configs").setup(config)

			---@class ParserInfo[]
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
					generate_requires_npm = true,
					requires_generate_from_grammer = true,
				},
				filetype = "blade",
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				max_lines = 7,
			})
			vim.api.nvim_set_hl(0, "TreesitterContext", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
		end,
	},
}
