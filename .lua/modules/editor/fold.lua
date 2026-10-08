-- [nfnl] fnl/modules/editor/fold.fnl
local Icons = require("icons")
local options = vim.opt
options.foldenable = true
options.foldcolumn = "1"
options.foldlevel = 99
options.foldlevelstart = 99
options.fillchars:append({fold = Icons.fold, foldclose = Icons.common.chevron_right, foldinner = " ", foldopen = Icons.common.chevron_down, foldsep = " "})
return a
