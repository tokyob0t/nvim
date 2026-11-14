(import-macros {: plugin!} :macros)

(local icons (require :icons))

(plugin! SmiteshP/nvim-navic
 {:event :LspAttach
  :opts {:highlight true
         :icons icons.kinds
         :lsp {:auto_attach true}
         :separator (.. " " icons.common.chevron_right " ")}})
