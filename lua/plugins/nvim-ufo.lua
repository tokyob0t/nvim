local options = vim.opt

return {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    keys = {
        { 'fc', '<cmd>foldclose<cr>' },
        { 'ff', '<cmd>foldopen<cr>' },
        { mode = 'v', 'fc', ":'<,'>foldclose<cr>" },
        { mode = 'v', 'ff', ":'<,'>foldopen<cr>" },
    },
    ---@type UfoConfig
    opts = {
        provider_selector = function(_bufnr, _filetype, _buftype)
            return { 'treesitter', 'indent' }
        end,
    },
}
