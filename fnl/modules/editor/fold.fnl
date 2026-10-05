(local Icons (require :icons))
(local options vim.opt)
(set options.foldenable true)
(set options.foldcolumn :1)
(set options.foldlevel 99)
(set options.foldlevelstart 99)
(options.fillchars:append {:fold Icons.fold
                           :foldclose Icons.common.chevron_right
                           :foldinner " "
                           :foldopen Icons.common.chevron_down
                           :foldsep " "})

a
