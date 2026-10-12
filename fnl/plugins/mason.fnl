(local icons (require :icons))

{1 :rahuliyer95/mason.nvim
 :branch :feat/1888/pnpm-installer
 :dependencies [:williamboman/mason-lspconfig.nvim]
 :opts {:max_concurrent_installers 5
        :npm {:use_pnpm true}
        :ui {:border :solid
             :check_outdated_packages_on_open true
             :icons {:package_installed icons.package.installed
                     :package_pending icons.package.pending
                     :package_uninstalled icons.package.uninstalled}
             :path :skip}}}
