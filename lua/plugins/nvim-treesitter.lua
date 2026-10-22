local createAutocmd = require('utils.createAutocmd')

local parsers = {
    'lua',
    'fennel',
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
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        ts.install(parsers):wait(300000)

        createAutocmd({ 'FileType' }, '*', function(args)
            pcall(vim.treesitter.start, args.buf)
        end)
    end,
}
