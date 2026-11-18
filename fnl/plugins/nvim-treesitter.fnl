(import-macros {: autocmd! : plugin!} :macros)

(plugin! nvim-treesitter/nvim-treesitter
 {:event [:BufReadPre :BufNewFile]
  :cmd [:TSInstall :TSInstallFromGrammar :TSUpdate :TSUninstall :TSLog]
  :build ":TSUpdate"
  :init (fn []
         (autocmd! FileType * `(do
                                (pcall vim.treesitter.start)
                                nil)))
  :config #(let [ts (require :nvim-treesitter)
                 parsers (require :parsers)]
            (ts.install parsers))})
