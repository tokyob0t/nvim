(import-macros {: autocmd!} :macros)

(local parsers (require :parsers))

{1 :nvim-treesitter/nvim-treesitter
 :lazy false
 :build ":TSUpdate"
 :config #(let [ts (require :nvim-treesitter)]
           (ts.install parsers)
           (autocmd! FileType * `(do
                                  (pcall vim.treesitter.start)
                                  nil)))}
