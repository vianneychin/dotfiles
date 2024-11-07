return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            'lua',
            'bash',
            'javascript',
            'jsdoc',
            'typescript',
            'rust',
            'php',
            'php_only',
            'nginx',
            'json',
            'html',
            'gitignore',
            'gitcommit',
            'gitattributes',
            'git_rebase',
            'git_config',
            'dockerfile',
            'css',
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --   If you are experiencing weird indenting issues, add the language to
            --   the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' }
        },
        indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, config)
        ---@class ParserInfo[]
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
                generate_requires_npm = true,
                requires_generate_from_grammer = true,
            },
            filetype = "blade"
        }
        require('nvim-treesitter.configs').setup(config);
    end
}
