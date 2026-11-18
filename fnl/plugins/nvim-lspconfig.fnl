(import-macros {: plugin!} :macros)

(local default-capabilities
 {:textDocument {:completion {:completionItem {:snippetSupport true}}
                 :foldingRange {:dynamicRegistration false :lineFoldingOnly true}}})

(plugin! neovim/nvim-lspconfig
 {:dependencies [:saghen/blink.cmp]
  :event [:BufReadPre :BufNewFile]
  :config #(let [servers (require :servers)
                 blink-cmp (require :blink.cmp)
                 capabilities (blink-cmp.get_lsp_capabilities default-capabilities)]
            (each [lsp settings (pairs servers)]
             (vim.lsp.config lsp (collect [k v (pairs settings) &into {: capabilities}]
                                  (values k v)))
             (vim.lsp.enable lsp)))})
