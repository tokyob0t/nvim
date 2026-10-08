(local icons (require :icons))
(local variables vim.v)

(local install-plugin (require :utils.installPlugin))

(local lazy (install-plugin :lazy :folke/lazy.nvim :stable))

; (fn ls [dir pattern]
;   (let [files (vim.fn.glob (.. dir "/" pattern) false true)]
;     (icollect [_ file (ipairs (vim.fn.split files "\n"))]
;       (if (not= file "")
;           (vim.fn.fnamemodify file ":t:r")))))

; (local files (ls "~/.config/nvim/.lua/plugins" :*.lua))

; (each [_ mod (ipairs files)]
;   (print mod))

(lazy.setup {:change_detection {:enabled false}
             :checker {:enabled true :notify false}
             :install {:colorscheme [:oxocarbon]}
             ; :spec [{:import :plugins}]
             ; :spec (let [files (ls "~/.config/nvim/.lua/plugins" :*.lua)]
             ;         (icollect [_ mod (ipairs files)]
             ;           (do
             ;             (print mod)
             ;             (require mod))))
             :ui {:title :lazy.nvim
                  :border :solid
                  :size {:height 0.9 :width 0.8}
                  :title_pos :center
                  :icons {:cmd icons.common.terminal
                          :favorite icons.common.bookmark
                          :keys icons.common.keymap
                          :lazy icons.common.lazy
                          :loaded icons.package.installed
                          :not_loaded icons.package.pending
                          :plugin icons.common.plugin
                          :require icons.common.lua
                          :source icons.common.source}}})
