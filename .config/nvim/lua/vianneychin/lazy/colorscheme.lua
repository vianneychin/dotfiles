return {
    -- {
    --     'folke/tokyonight.nvim',
    --     priority = 1000,
    --     init = function()
    --         vim.cmd.colorscheme 'tokyonight-night'
    --
    --         -- You can configure highlights by doing something like:
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                color_overrides = {
                    mocha = {
                        base = "#14141c"
                    }
                },
                custom_highlights = {},
            })
            vim.cmd.colorscheme 'catppuccin-mocha'
        end,
    }
}
