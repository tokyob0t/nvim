(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! lewis6991/gitsigns.nvim
 {:event [:BufReadPre :BufNewFile]
  :opts {:signs_staged_enable false
         :signs (collect [key value (pairs icons.gutter)]
                 (values key {:text value}))}})
