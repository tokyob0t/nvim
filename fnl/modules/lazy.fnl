(local icons (require :icons))
(local variables vim.v)

(local install-plugin (require :utils.installPlugin))

(local lazy (install-plugin :lazy :folke/lazy.nvim :stable))

(local api (require :hotpot.api))
(local ctx (assert (api.context (vim.fn.stdpath :config))))

(fn list-fennel-files [path]
  (let [path (.. path :/*.fnl)
        files (vim.fn.glob path false true)]
    (icollect [_ file (ipairs files)]
      (if (not= file "")
          (vim.fn.fnamemodify file ":t:r")))))

(lazy.setup {:change_detection {:enabled false}
             :checker {:enabled true :notify false}
             :install {:colorscheme [:oxocarbon]}
             :performance {:rtp {:paths [(ctx.locate :destination)]}
                           :reset_packpath false}
             :spec (let [directory "~/.config/nvim/fnl/plugins"
                         files (list-fennel-files directory)
                         only (or (os.getenv :NVIM_ONLY) "")
                         specs []]
                     (each [_ f (ipairs files)]
                       (when (or (= only "") (not (not (string.find f only))))
                         (table.insert specs (require (.. :plugins. f)))))
                     specs)
             :ui {:border :solid
                  :icons {:cmd icons.common.terminal
                          :favorite icons.common.bookmark
                          :keys icons.common.keymap
                          :lazy icons.common.lazy
                          :loaded icons.package.installed
                          :not_loaded icons.package.pending
                          :plugin icons.common.plugin
                          :require icons.common.lua
                          :source icons.common.source}
                  :size {:height 0.9 :width 0.8}
                  :title :lazy.nvim
                  :title_pos :center}})
