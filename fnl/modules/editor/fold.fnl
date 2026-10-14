(import-macros {: let! : set!} :macros)

(local icons (require :icons))

(set! foldenable)
(set! foldcolumn :1)
(set! foldlevel 99)
(set! foldlevelstart 99)

(set! fillchars+ {:fold icons.fold
                  :foldclose icons.common.chevron_right
                  :foldinner " "
                  :foldopen icons.common.chevron_down
                  :foldsep " "})
