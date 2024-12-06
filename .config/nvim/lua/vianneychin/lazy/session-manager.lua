return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {},
	config = function()
		require("persistence").setup({
			dir = vim.fn.stdpath("state") .. "/sessions/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"), -- Save sessions per project
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- Adjust 'sessionoptions' as needed
		})
	end,
}
