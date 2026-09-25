local Icons = require('icons')

local options = vim.opt

options.foldcolumn = '1'
options.foldlevel = 99
options.foldlevelstart = 99
options.foldenable = true

options.fillchars:append {
    fold = Icons.fold,
    foldinner = ' ',
    foldsep = ' ',
    foldclose = Icons.common.chevron_right,
    foldopen = Icons.common.chevron_down,
}
