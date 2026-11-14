(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! razak17/tailwind-fold.nvim
 {:dependencies [:nvim-treesitter/nvim-treesitter] :opts {:symbol icons.fold}})
