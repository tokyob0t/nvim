(local parsers [:lua
                :python
                :vim
                :html
                :html_tags
                :javascript
                :css
                :scss
                :vimdoc
                :bash
                :markdown
                :rust
                :xml
                :json
                :meson
                :toml
                :gitignore
                :gitcommit
                :git_config
                :comment])

{1 :nvim-treesitter/nvim-treesitter
 :branch :main
 :build ":TSUpdate"
 :config (fn []
           (local ts (require :nvim-treesitter))
           (-> (ts.install parsers)
               (: :wait 300000))
           (vim.api.nvim_create_autocmd :FileType
                                        {:callback (fn [{: buf}]
                                                     (pcall vim.treesitter.start
                                                            buf))}))
 :init (fn [])
 :lazy false}
