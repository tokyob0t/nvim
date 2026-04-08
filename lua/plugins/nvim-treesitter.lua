local parsers = {
    'lua',
    'python',
    'vim',
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
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        for _, parser in ipairs(parsers) do
            pcall(ts.install, parser)
        end

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
