(import-macros {: plugin!} :macros)

(plugin! nvim-treesitter/nvim-treesitter
 {:event [:BufReadPre :BufNewFile]
  :cmd [:TSInstall :TSInstallFromGrammar :TSUpdate :TSUninstall :TSLog]
  :build ":TSUpdate"
  :config (fn []
           (let [ts (require :nvim-treesitter)
                 parsers (require :parsers)]
            (ts.install parsers)))})
