(local icons (require :icons))

(local install-plugin (require :utils.installPlugin))

(local lazy (install-plugin :lazy :folke/lazy.nvim :stable))

(local cfg (vim.fn.stdpath :config))

;; set by init.lua when it boots from the hotpot cache; the fallback matches
;; where hotpot writes compiled output for a config-root context
(local destination (or (. vim.g :hotpot_cache_dir)
                    (.. (vim.fn.stdpath :data) :/site/pack/hotpot/opt/hotpot-config-cache)))

;; utils.specsBundle concatenates the compiled specs into one file; the fallback
;; requires them one by one straight from the cache, which is also the list the
;; bundle is built from, so there is a single source of truth for what exists
(fn list-fennel-plugins []
 (let [bundle (require :utils.specsBundle)]
  (or (bundle.load) (let [names (bundle.names)
                          display-error #(vim.notify (.. "Failed to load plugin '" $1 "':\n" $2) vim.log.levels.ERROR)]
                     (if (= 0 (length names))
                         (do
                          (vim.notify "No compiled plugin specs, run :HotpotSync" vim.log.levels.ERROR)
                          [])
                         (icollect [_ mod (ipairs names)]
                          (let [(ok? plugin) (pcall require mod)]
                           (if ok? plugin (display-error mod plugin)))))))))

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
