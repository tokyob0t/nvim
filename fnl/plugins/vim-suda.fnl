(import-macros {: plugin! : let!} :macros)

(plugin! lambdalisue/vim-suda
 {:cmd [:SudaRead :SudaWrite] :init (fn [] (let! suda_smart_edit 1))})
