(import-macros {: autocmd! : set!} :macros)

(local icons (require :icons))
(local servers (require :servers))

{1 "williamboman/mason-lspconfig.nvim"
 :init #(autocmd! [BufRead BufNewFile] *.tl
                  (fn []
                    (set! syntax "lua")
                    (let [client-id (vim.lsp.start {:cmd [:teal-language-server]
                                                    :filetypes [:teal]
                                                    :root_dir (vim.fn.getcwd)})]
                      (if client-id
                          (vim.lsp.buf_attach_client 0 client-id)))))
 ; vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
 ;   pattern = "*.tl",
 ;   callback = function()
 ;     vim.cmd("set syntax=lua") -- Use Lua syntax highlighting
 ;     -- Start the ls
 ;     local client_id = vim.lsp.start({
 ;       cmd = { "/usr/bin/teal-language-server" },
 ;       filetypes = { "teal" }, -- Attach LSP for Teal files
 ;       root_dir = vim.fn.getcwd(), -- Use current working directory as root
 ;     })
 ;     -- Attach the current buffer to the client
 ;     if client_id then
 ;       vim.lsp.buf_attach_client(0, client_id)
 ;     end
 ;   end,
 ; })
 :opts {:automatic_enable false
        ; :ensure_installed (vim.tbl_keys servers)
        }
 :dependencies [{1 :rahuliyer95/mason.nvim
                 :branch "feat/1888/pnpm-installer"
                 :opts {:max_concurrent_installers 5
                        :npm {:use_pnpm true}
                        :ui {:border :solid
                             :path :skip
                             :check_outdated_packages_on_open true
                             :icons {:package_installed icons.package.installed
                                     :package_pending icons.package.pending
                                     :package_uninstalled icons.package.uninstalled}}}}]}
