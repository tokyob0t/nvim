(import-macros {: plugin!} :macros)

(local icons (require :icons))
(local servers (require :servers))

(plugin! williamboman/mason-lspconfig.nvim
 {:opts {:automatic_enable false :ensure_installed (vim.tbl_keys servers)}
  :dependencies [{1 :rahuliyer95/mason.nvim
                  :branch "feat/1888/pnpm-installer"
                  :opts {:max_concurrent_installers 5
                         :npm {:use_pnpm true}
                         :ui {:border :solid
                              :path :skip
                              :check_outdated_packages_on_open true
                              :icons {:package_installed icons.package.installed
                                      :package_pending icons.package.pending
                                      :package_uninstalled icons.package.uninstalled}}}}]})
