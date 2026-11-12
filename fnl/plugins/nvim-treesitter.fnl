(import-macros {: autocmd!} :macros)

(local parsers (require :parsers))

{1 :nvim-treesitter/nvim-treesitter
 :lazy false
 :build ":TSUpdate"
 :config #(let [ts (require :nvim-treesitter)]
            (ts.install parsers)
            (autocmd! FileType *
                      (fn [{: buf}]
                        (local (e e) (pcall vim.treesitter.start buf)))))}
