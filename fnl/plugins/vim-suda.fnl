(import-macros {: plugin!} :macros)

(import-macros {: let! : set!} :macros)

(plugin! lambdalisue/vim-suda
 {:event :VeryLazy
  :init (fn []
         (let! suda_smart_edit 1))})
