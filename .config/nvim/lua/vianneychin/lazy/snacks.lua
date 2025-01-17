return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your coifiguration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		words = { enabled = true },
		bufdelete = { enabled = true },
	},
	keys = {
		-- {
		-- 	"<leader>q",
		-- 	function()
		-- 		Snacks.bufdelete()
		-- 	end,
		-- 	desc = "Delete Buffer",
		-- },
	},
}
