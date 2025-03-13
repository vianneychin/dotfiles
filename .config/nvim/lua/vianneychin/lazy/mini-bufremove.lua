return {
    "echasnovski/mini.bufremove",
    version = "*",
    opts = {},
    config = function()
        local miniRemove = require('mini.bufremove')
        local special_filetypes = {
            "lazy",
            "qf", -- quickfix
            "copilot-chat",
            "harpoon"
        }
        
        vim.keymap.set("n", "<leader>q", function()
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_get_current_buf()
            local current_ft = vim.bo[buf].filetype
            
            -- Check if it's a floating window or matches special filetypes
            if vim.api.nvim_win_get_config(win).relative ~= "" or vim.tbl_contains(special_filetypes, current_ft) then
                vim.cmd("bdelete!") -- Added the ! to force close
            else
                miniRemove.delete()
            end
        end, { silent = true })
    end,
}
