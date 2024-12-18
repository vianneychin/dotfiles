return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
  }
}
-- return {
-- 	"folke/persistence.nvim",
-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
-- 	opts = {},
-- 	config = function()
-- 		require("persistence").setup({
-- 			dir = vim.fn.stdpath("state") .. "/sessions/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"), -- Save sessions per project
-- 			options = { "buffers", "curdir", "tabpages", "winsize" }, -- Adjust 'sessionoptions' as needed
-- 		})
-- 	end,
-- }
