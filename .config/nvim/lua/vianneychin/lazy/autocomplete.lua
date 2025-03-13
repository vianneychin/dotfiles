return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		version = "v0.*",
		---@module 'blink.cmp'
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				-- providers = {
				-- 	lsp = {
				-- 		override = {
				-- 			get_trigger_characters = function(self)
				-- 				local trigger_characters = self:get_trigger_characters()
				-- 				vim.list_extend(trigger_characters, { "\n", "\t", " " })
				-- 				return trigger_characters
				-- 			end,
				-- 		},
				-- 	},
				-- },
			},
			completion = {
				-- ghost_text = { enabled = true },
				accept = { auto_brackets = { enabled = false } },
				-- Don't select by default, auto insert on selection
				list = { selection = { preselect = false, auto_insert = true } },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				trigger = {
					prefetch_on_insert = true,
					-- INFO: Check on this periodically because it doesn't work
					-- https://github.com/Saghen/blink.cmp/issues/836
					show_on_blocked_trigger_characters = {},
				},
				menu = {
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
