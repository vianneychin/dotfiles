return {
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
