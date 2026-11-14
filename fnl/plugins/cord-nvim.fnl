(import-macros {: plugin!} :macros)

(plugin! vyfor/cord.nvim
 {:opts {:advanced {:discord {:reconnect {:enabled true}}}
         :text {:editing (fn [{: filename : cursor_line : cursor_char}]
                          (.. :Editing filename "-" cursor_line ":" cursor_char))}}})
