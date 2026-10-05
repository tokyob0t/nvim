local option = vim.opt
local cmd = vim.cmd

return {
    'tokyob0t/oxocarbon.nvim',
    build = false,
    init = function()
        option.background = 'dark'
        cmd.colorscheme('oxocarbon')
    end,
}
