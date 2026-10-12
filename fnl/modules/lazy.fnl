(local icons (require :icons))
(local variables vim.v)

(local install-plugin (require :utils.installPlugin))

(local lazy (install-plugin :lazy :folke/lazy.nvim :stable))

(fn listPlugins [?plugins-directory]
  (let [plugins-directory (or ?plugins-directory
                              "~/.config/nvim/.lua/plugins/*.lua")
        files (vim.fn.glob plugins-directory false true)]
    (icollect [_ file (ipairs files)]
      (if (not= file "")
          (vim.fn.fnamemodify file ":t:r")))))

(lazy.setup (let [plugins (listPlugins)
                  plugins (icollect [_ p (ipairs plugins)]
                            (require (.. :plugins. p)))]
              {:change_detection {:enabled false}
               :checker {:enabled true :notify false}
               :install {:colorscheme [:oxocarbon]}
               :spec plugins
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
                    :title_pos :center}}))
