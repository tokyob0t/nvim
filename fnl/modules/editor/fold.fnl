(local icons (require :icons))
(local options vim.opt)
(set options.foldenable true)
(set options.foldcolumn :1)
(set options.foldlevel 99)
(set options.foldlevelstart 99)

(options.fillchars:append {:fold icons.fold
                           :foldclose icons.common.chevron_right
                           :foldinner " "
                           :foldopen icons.common.chevron_down
                           :foldsep " "})
