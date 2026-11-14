(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! razak17/tailwind-fold.nvim
 {:dependencies [:nvim-treesitter/nvim-treesitter]
  :ft [:html :css :scss :javascript :javascriptreact :typescript :typescriptreact :astro :svelte :vue :php]
  :opts {:symbol icons.fold}})
