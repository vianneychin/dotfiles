return {
	"sschleemilch/slimline.nvim",
	opts = {
		style = "fg",
		components = {
			left = {
				"mode",
				"path",
				-- Remove 'git' from here
			},
		},

		configs = {
			path = {
				icons = {
					-- Change the dot to the defualt vim character for a change on the current file
					modified = "[+]",
				},
			},
		},
	},
}
