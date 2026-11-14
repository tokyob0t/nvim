(import-macros {: plugin!} :macros)

;; devicons is only needed once something asks for an icon (the winbar on a
;; real file, blink, nvim-tree). Keep it and the 1900 entry material table
;; out of the startup path.
(plugin! nvim-tree/nvim-web-devicons
 {:lazy true
  :config (fn []
           (let [material (require :material-icons)
                 ext {:fnl {:icon "" :color "#FFF3D7" :name :Fennel}
                      :fnlm {:icon "" :color "#F5E8C8" :name :FennelMacro}
                      :tl {:icon "" :color "#00e0e0" :name :Teal}}]
            ((. (require :nvim-web-devicons) :setup) {:override_by_extension (vim.tbl_extend :force
                                                                              (. material :by_extension) ext)
                                                      :override_by_filename (. material :by_filename)})))})
