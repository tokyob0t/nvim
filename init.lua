local variables = vim.v
local globals = vim.g

local icons = require('icons')
local installPlugin = require('utils.installPlugin')

globals.mapleader = ' '

local hotpot = installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')

-- if hotpot then
--     vim.cmd('Hotpot sync')
-- end

-- require('modules')

require('modules.lazy')
require('modules.settings')
require('modules.keymaps')
require('modules.editor')
