(local servers (require :servers))

(local default-capabilities
       {:textDocument {:completion {:completionItem {:snippetSupport true}}
                       :foldingRange {:dynamicRegistration false
                                      :lineFoldingOnly true}}})

{1 :neovim/nvim-lspconfig
 :dependencies [:saghen/blink.cmp]
 :config #(let [cmp (require :blink.cmp)
                capabilities (cmp.get_lsp_capabilities default-capabilities)]
            (each [lsp settings (pairs servers)]
              (local opts (collect [k v (pairs settings) &into {: capabilities}]
                            k
                            v))
              (vim.lsp.config lsp opts)
              (vim.lsp.enable lsp)))}
