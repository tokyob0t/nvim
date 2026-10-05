(local Icons (require :icons))
(local variables vim.v)
(fn handle-error [err]
  (vim.api.nvim_echo [[err :ErrorMsg]
                      ["\nPress any key to exit..." :WarningMsg]]
                     true {})
  (vim.fn.getchar)
  (os.exit 1))

(fn git-clone [repo-url branch clone-path]
  (let [out (vim.fn.system [:git
                            :clone
                            "--filter=blob:none"
                            (.. :--branch= branch)
                            repo-url
                            clone-path])]
    (when (not= variables.shell_error 0)
      (error (.. "Failed to clone " repo-url ":\n" out)))))

(fn install-plugin [plugin branch]
  (let [(_ repo) (string.match plugin "(.+)/(.+)")
        repo-path (.. (vim.fn.stdpath :data) :/lazy/ repo)]
    (when (not (vim.uv.fs_stat repo-path))
      (vim.notify (.. "Installing " plugin " " branch))
      (git-clone (.. "https://github.com/" plugin :.git) branch repo-path))
    (vim.opt.rtp:prepend repo-path)))

(install-plugin :folke/lazy.nvim :stable)

(local lazy (require :lazy))

(lazy.setup {:change_detection {:enabled false}
             :checker {:enabled true :notify false}
             :install {:colorscheme [:oxocarbon]}
             :spec [{:import :plugins}]
             :ui {:border :solid
                  :icons {:cmd Icons.common.terminal
                          :favorite Icons.common.bookmark
                          :keys Icons.common.keymap
                          :lazy Icons.common.lazy
                          :loaded Icons.package.installed
                          :not_loaded Icons.package.pending
                          :plugin Icons.common.plugin
                          :require Icons.common.lua
                          :source Icons.common.source}
                  :size {:height 0.9 :width 0.8}
                  :title :lazy.nvim
                  :title_pos :center}})
