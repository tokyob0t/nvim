(import-macros {: plugin!} :macros)

(local default-capabilities
 {:textDocument {:completion {:completionItem {:snippetSupport true}}
                 :foldingRange {:dynamicRegistration false :lineFoldingOnly true}}})

(plugin! neovim/nvim-lspconfig
 {:dependencies [:saghen/blink.cmp]
  :event [:BufReadPre :BufNewFile]
  :config (fn []
           (let [servers (require :servers)
                 cmp (require :blink.cmp)
                 capabilities (cmp.get_lsp_capabilities default-capabilities)]
            (each [lsp settings (pairs servers)]
             (vim.lsp.config lsp (collect [k v (pairs settings) &into {: capabilities}]
                                  (values k v)))
             (vim.lsp.enable lsp))))})
