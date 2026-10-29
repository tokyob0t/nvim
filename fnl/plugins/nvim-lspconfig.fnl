(local servers {:astro {}
                :bashls {}
                :biome {}
                :blueprint_ls {}
                :clangd {}
                :cssls {}
                :emmet_language_server {:init_options {:showSuggestionsAsSnippets true}}
                :emmylua_ls {}
                :fennel_ls {}
                ; :fennel_language_server {}
                :gopls {:settings {:gopls {:semanticTokens true
                                           :usePlaceholders true}}}
                :groovyls {}
                :jdtls {}
                :jedi_language_server {}
                :jsonls {}
                :lemminx {}
                :marksman {}
                :mesonlsp {}
                :nil_ls {}
                :pasls {}
                :perlpls {}
                :postgres_lsp {}
                :qmlls {:on_init (fn [client]
                                   (vim.lsp.semantic_tokens.enable false
                                                                   {:client_id client.id}))}
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
 :dependencies [:saghen/blink.cmp]
 :config #(let [capabilities (-> (require :blink.cmp)
                                 (: :get_lsp_capabilities default-capabilities))]
            (each [lsp settings (pairs servers)]
              (let [opts {: capabilities}]
                (each [k v (pairs settings)]
                  (set (. opts k) v)) ; (vim.lsp.config lsp opts)
                (vim.lsp.enable lsp))))}
