(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! lukas-reineke/indent-blankline.nvim
 {:main :ibl
  :event [:BufReadPost :BufNewFile]
  :opts {:indent {:char icons.indent} :exclude {:filetypes [:fennel :clojure :lisp :racket :scheme]}}})
