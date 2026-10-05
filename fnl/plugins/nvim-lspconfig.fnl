(local servers {:astro {}
                :bashls {}
                :biome {}
                :blueprint_ls {}
                :clangd {}
                :cssls {}
                :emmet_language_server {:init_options {:showSuggestionsAsSnippets true}}
                :emmylua_ls {}
                :fennel_ls {}
                :gopls {:settings {:gopls {:semanticTokens true
                                           :usePlaceholders true}}}
                :groovyls {}
                :jdtls {}
                :jsonls {}
                :lemminx {}
                :marksman {}
                :mesonlsp {}
                :nil_ls {}
                :pasls {}
                :perlpls {}
                :postgres_lsp {}
                :pylsp {}
                :r_language_server {}
                :ruff {}
                :rust_analyzer {}
                :sqls {}
                :taplo {}
                :ts_ls {}
                :vala_ls {}})

(local default-capabilities
       {:textDocument {:completion {:completionItem {:snippetSupport true}}
                       :foldingRange {:dynamicRegistration false
                                      :lineFoldingOnly true}}})

{1 :neovim/nvim-lspconfig
 :config (fn []
           (local capabilities
                  ((. (require :blink.cmp) :get_lsp_capabilities) default-capabilities))
           (each [lsp settings (pairs servers)]
             (local opts {: capabilities})
             (each [k v (pairs settings)] (tset opts k v))
             (vim.lsp.config lsp opts)
             (vim.lsp.enable lsp)))
 :dependencies [:saghen/blink.cmp]}
