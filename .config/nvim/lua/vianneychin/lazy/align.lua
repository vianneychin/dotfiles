return {
	"echasnovski/mini.align",
	version = false,
	config = function()
		local miniAlign = require("mini.align")
		miniAlign.setup({
			mappings = {
				start = "<leader>;",
				start_with_preview = "",
                -- Add a custom mapping for '=' alignment
                ['<leader>='] = function()
                    miniAlign.align_operator({ split_pattern = '=' })
                end,
			},
		})
	end,
}
