(import-macros {: autocmd! : plugin!} :macros)

(local parsers (require :parsers))

(plugin! nvim-treesitter/nvim-treesitter
 {:event [:BufReadPre :BufNewFile]
  :build ":TSUpdate"
  :config (fn []
           (let [ts (require :nvim-treesitter)]
            (ts.install parsers)
            (autocmd! FileType * `(do
                                   (pcall vim.treesitter.start)
                                   nil))))})
