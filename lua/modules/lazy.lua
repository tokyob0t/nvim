local icons = require('icons')
local variables = vim.v

local function handleError(err)
    vim.api.nvim_echo({
        { err, 'ErrorMsg' },
        { '\nPress any key to exit...', 'WarningMsg' },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
end

local function gitClone(repo_url, branch, clone_path)
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=' .. branch,
        repo_url,
        clone_path,
    }

    if variables.shell_error ~= 0 then
        error('Failed to clone ' .. repo_url .. ':\n' .. out)
    end
end

local function installPlugin(plugin, branch)
    local _, repo = string.match(plugin, '(.+)/(.+)')
    local repo_path = vim.fn.stdpath('data') .. '/lazy/' .. repo

    if not vim.uv.fs_stat(repo_path) then
        vim.notify('Installing ' .. plugin .. ' ' .. branch)

        gitClone('https://github.com/' .. plugin .. '.git', branch, repo_path)
    end

    vim.opt.rtp:prepend(repo_path)
end

installPlugin('folke/lazy.nvim', 'stable')
-- local hotpot_path = ensure_installed('rktjmp/hotpot.nvim', 'v2.1.2')

local lazy = require('lazy')

lazy.setup {
    install = {
        colorscheme = { 'oxocarbon' },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    spec = {
        { import = 'plugins' },
    },
    change_detection = {
        enabled = false,
    },
    ui = {
        border = 'solid',
        title = 'lazy.nvim',
        title_pos = 'center',
        size = {
            width = 0.8,
            height = 0.9,
        },
        icons = {
            cmd = icons.common.terminal,
            favorite = icons.common.bookmark,
            keys = icons.common.keymap,
            lazy = icons.common.lazy,
            loaded = icons.package.installed,
            not_loaded = icons.package.pending,
            plugin = icons.common.plugin,
            require = icons.common.lua,
            source = icons.common.source,
        },
    },
}
