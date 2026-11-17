(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! williamboman/mason-lspconfig.nvim
 {:event :LspAttach
  :cmd [:Mason :MasonInstall :MasonUninstall :MasonUpdate :MasonLog :MasonInstallAll]
  :opts {:automatic_enable false
         ; :ensure_installed (vim.tbl_keys servers)
         }
  :dependencies [(plugin! rahuliyer95/mason.nvim
                  {:branch "feat/1888/pnpm-installer"
                   :opts {:max_concurrent_installers 5
                          :npm {:use_pnpm true}
                          :ui {:border :solid
                               :path :skip
                               :check_outdated_packages_on_open true
                               :icons {:package_installed icons.package.installed
                                       :package_pending icons.package.pending
                                       :package_uninstalled icons.package.uninstalled}}}})]})
