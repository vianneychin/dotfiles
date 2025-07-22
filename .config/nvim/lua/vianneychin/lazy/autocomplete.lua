return {
	{
		"saghen/blink.cmp",
		optional = true,

		-- lazy loading handled internally
		lazy = false,
		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			cmdline = {
				completion = {
					menu = { auto_show = true },
				},
				keymap = {
					-- Run command as soon as command is accepted
					["<C-y>"] = { "accept_and_enter", "fallback" },
				},
			},
			sources = {
				default = {
					-- "laravel",
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
				-- providers = {
				-- 	laravel = {
				-- 		name = "laravel",
				-- 		module = "laravel.blink_source",
				-- 		score_offset = 1000,
				-- 	},
				-- },
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = true,
					show_on_keyword = true,
				},
				list = { selection = { preselect = true, auto_insert = true } },
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "rounded",
					},
				},
				menu = {
					auto_show = true,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
						treesitter = { "lsp" },
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				ghost_text = {
					enabled = vim.g.ai_cmp,
				},
			},
		},
	},
}
