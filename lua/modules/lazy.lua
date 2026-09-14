local os_name = vim.loop.os_uname().sysname

local lazypath = vim.env.LAZY_PATH

if not lazypath then
    if string.find(os_name, 'Windows') then
        lazypath = vim.fn.stdpath('data') .. '\\lazy\\lazy.nvim'
    else
        lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    end
end

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    install = { colorscheme = { 'oxocarbon' } },
    spec = {
        { import = 'plugins' },
    },
})
