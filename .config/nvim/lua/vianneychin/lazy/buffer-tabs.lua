return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.keymap.set("n", "<leader>H", "<Cmd>BufferLineCyclePrev<CR>",
            { desc = "Go to previous buffer tab", silent = true })
        vim.keymap.set("n", "<leader>L", "<Cmd>BufferLineCycleNext<CR>",
            { desc = "Go to next buffer tab", silent = true })
        vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true })
        vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true })
        vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true })
        vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true })
        vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true })
        vim.keymap.set("n", "<leader>Q", "<Cmd>BufferLineCloseOthers<CR>", { silent = true })
        vim.keymap.set("n", "<leader>q", function()
            local bufnum = vim.api.nvim_get_current_buf()
            vim.cmd("bdelete " .. bufnum)
        end, { silent = true })
        require("bufferline").setup({
            highlights = {
                fill = {
                    fg = "none",
                    bg = "none"
                },
            },
            options = {
                numbers = 'none',
                tab_size = 0,
                indicator = {
                    icon = '|',
                },
                show_buffer_close_icons = false,
                show_buffer_icons = false,
                modified_icon = 'c',
                show_close_icon = false,
                show_tab_indicators = false,
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 18,
                max_prefix_length = 15,
                truncate_names = true,
                color_icons = false,
                separator_style = "thin",
                enforce_regular_tabs = false,
                hover = {
                    enabled = false,
                },
            },
        })
    end
}
