(import-macros {: autocmd! : plugin!} :macros)

(plugin! nvim-treesitter/nvim-treesitter
 {:event [:BufReadPre :BufNewFile]
  :cmd [:TSInstall :TSInstallFromGrammar :TSUpdate :TSUninstall :TSLog]
  :build ":TSUpdate"
  :init (fn []
         ;; init runs at startup even though the plugin is lazy, so buffers
         ;; whose filetype is set outside of :e (fff previews, scratch, ...)
         ;; get highlighting before anything has loaded the plugin
         (autocmd! FileType * `(do
                                (pcall vim.treesitter.start)
                                nil)))
  :config (fn []
           (let [ts (require :nvim-treesitter)
                 parsers (require :parsers)]
            (ts.install parsers)))})
