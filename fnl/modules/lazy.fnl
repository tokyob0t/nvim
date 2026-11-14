(local icons (require :icons))

(local install-plugin (require :utils.installPlugin))

(local lazy (install-plugin :lazy :folke/lazy.nvim :stable))

(local cfg (vim.fn.stdpath :config))

;; set by init.lua when it boots from the hotpot cache; the fallback matches
;; where hotpot writes compiled output for a config-root context
(local destination (or (. vim.g :hotpot_cache_dir)
                    (.. (vim.fn.stdpath :data) :/site/pack/hotpot/opt/hotpot-config-cache)))

(fn list-fennel-files [path]
 (let [path (.. path :/*.fnl)
       files (vim.fn.glob path false true)]
  (icollect [_ file (ipairs files)]
   (if (not= file "")
       (vim.fn.fnamemodify file ":t:r")))))

(fn list-fennel-plugins []
 (let [LogLevels vim.log.levels
       directory (.. cfg :/fnl/plugins)
       files (list-fennel-files directory)
       display-error #(vim.notify (.. "Failed to load plugin '" $1 "':\n" $2) LogLevels.ERROR)]
  (icollect [_ file (ipairs files)]
   (let [mod (.. :plugins. file)
         (ok p) (pcall require mod)]
    (if ok p (display-error file p))))))

(lazy.setup {:change_detection {:enabled false}
             :checker {:enabled true :notify false}
             :spec (list-fennel-plugins)
             :performance {:rtp {:paths [destination]} :reset_packpath false}
             :ui {:title :lazy.nvim
                  :title_pos :center
                  :border :solid
                  :size {:height 0.9 :width 0.8}
                  :icons {:cmd icons.common.terminal
                          :favorite icons.common.bookmark
                          :keys icons.common.keymap
                          :lazy (.. icons.common.lazy " ")
                          :loaded icons.package.installed
                          :not_loaded icons.package.pending
                          :plugin icons.common.plugin
                          :require icons.common.lua
                          :source icons.common.source}}})
