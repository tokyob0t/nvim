-- [nfnl] fnl/modules/lazy.fnl
local icons = require("icons")
local variables = vim.v
local install_plugin = require("utils.installPlugin")
local lazy = install_plugin("lazy", "folke/lazy.nvim", "stable")
return lazy.setup({change_detection = {enabled = false}, checker = {enabled = true, notify = false}, install = {colorscheme = {"oxocarbon"}}, ui = {title = "lazy.nvim", border = "solid", size = {height = 0.9, width = 0.8}, title_pos = "center", icons = {cmd = icons.common.terminal, favorite = icons.common.bookmark, keys = icons.common.keymap, lazy = icons.common.lazy, loaded = icons.package.installed, not_loaded = icons.package.pending, plugin = icons.common.plugin, require = icons.common.lua, source = icons.common.source}}})
