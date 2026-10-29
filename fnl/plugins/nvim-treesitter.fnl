(import-macros {: autocmd!} :macros)

(local parsers [:lua
                :fennel
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
 :lazy false
 :build ":TSUpdate"
 :config #(let [ts (require :nvim-treesitter)]
            (: (ts.install parsers) :wait 300000)
            (autocmd! FileType * #(pcall vim.treesitter.start $.buf)))}
