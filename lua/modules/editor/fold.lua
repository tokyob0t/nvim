local icons = require('icons')

local options = vim.opt

options.foldenable = true
options.foldcolumn = '1'
options.foldlevel = 99
options.foldlevelstart = 99

options.fillchars:append {
    fold = icons.fold,
    foldinner = ' ',
    foldsep = ' ',
    foldclose = icons.common.chevron_right,
    foldopen = icons.common.chevron_down,
}
