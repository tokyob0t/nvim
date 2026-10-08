vim.g.mapleader = ' '

-- require('modules.lazy')
-- require('modules.settings')
-- require('modules.keymaps')
-- require('modules.editor')

local icons = require('icons')
local variables = vim.v

local installPlugin = require('utils.installPlugin')

-- installPlugin('lazy', 'folke/lazy.nvim', 'stable')

local nfnl = installPlugin('nfnl.api', 'Olical/nfnl', 'main')

nfnl['compile-all-files']() -- transpile fnl/example.fnl -> .lua/example.lua

package.path = vim.fn.stdpath('config') .. '/.lua/?.lua;' .. package.path
package.path = vim.fn.stdpath('config') .. '/.lua/?/init.lua;' .. package.path

require('modules')
