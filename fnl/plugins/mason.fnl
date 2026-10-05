{[1] :williamboman/mason.nvim
 :cmd [:Mason :MasonInstall :MasonUninstall :MasonUpdate :MasonLog]
 :dependencies [{[1] :williamboman/mason-lspconfig.nvim}
                {[1] :neovim/nvim-lspconfig}]
 :config (fn []
           (local mason (require :mason))
           (local mason-lspconfig (require :mason-lspconfig))
           (mason.setup {:ui {:border :solid
                              :width 0.8
                              :height 0.9
                              :title_pos :center
                              :icons {:package_installed "✓"
                                      :package_pending "➜"
                                      :package_uninstalled "✗"}}})
           (mason-lspconfig.setup {:ensure_installed [:lua_ls :ts_ls :rust_analyzer :fennel_language_server]
                                   :automatic_enable true}))}
