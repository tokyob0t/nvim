local globals = vim.g

return {
    'lambdalisue/vim-suda',
    event = 'VeryLazy',
    init = function()
        globals.suda_smart_edit = 1
    end,
}
