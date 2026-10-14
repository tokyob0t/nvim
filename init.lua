local variables = vim.v
local globals = vim.g

local icons = require('icons')
local installPlugin = require('utils.installPlugin')

globals.mapleader = ' '

local hotpot = installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')

require('modules')
