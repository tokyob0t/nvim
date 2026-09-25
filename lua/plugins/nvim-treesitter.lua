local parsers = {
    'lua',
    'python',
    'vim',
    'html',
    'html_tags',
    'javascript',
    'css',
    'scss',
    'vimdoc',
    'bash',
    'markdown',
    'rust',
    'xml',
    'json',
    'meson',
    'toml',
    'gitignore',
    'gitcommit',
    'git_config',
    'comment',
}

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    init = function() end,
    config = function()
        local ts = require('nvim-treesitter')

        ts.install(parsers):wait(300000)

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
