vim.g.mapleader = ' '

-- require('modules.lazy')
-- require('modules.settings')
-- require('modules.keymaps')
-- require('modules.editor')

local icons = require('icons')
local variables = vim.v

local function handleError(err)
    vim.api.nvim_echo({
        { err, 'ErrorMsg' },
        { '\nPress any key to exit...', 'WarningMsg' }
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
end

local function gitClone(repo_url, branch, clone_path)
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=' .. branch, repo_url, clone_path }

    if variables.shell_error ~= 0 then
        error('Failed to clone ' .. repo_url .. ':\n' .. out)
    end
end

local function installPlugin(module, plugin, branch)
    local _, repo = string.match(plugin, '(.+)/(.+)')
    local repo_path = vim.fn.stdpath('data') .. '/lazy/' .. repo

    if not vim.uv.fs_stat(repo_path) then
        vim.notify('Installing ' .. plugin .. ' ' .. branch)

        gitClone('https://github.com/' .. plugin .. '.git', branch, repo_path)
    end

    vim.opt.runtimepath:prepend({ repo_path })
end

installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')
installPlugin('lazy', 'folke/lazy.nvim', 'stable')

require('hotpot')

require "config.init"
