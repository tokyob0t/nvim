(import-macros {: plugin!} :macros)

(local ext {:fnl {:icon "" :color "#FFF3D7" :name :Fennel}
            :fnlm {:icon "" :color "#F5E8C8" :name :FennelMacro}
            :tl {:icon "" :color "#00e0e0" :name :Teal}})

(local material (require :material-icons))

(plugin! nvim-tree/nvim-web-devicons
 {:opts {:override_by_extension (vim.tbl_extend :force (. material :by_extension) ext)
         :override_by_filename (. material :by_filename)}})
