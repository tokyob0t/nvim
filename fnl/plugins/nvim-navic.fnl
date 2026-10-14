(local icons (require :icons))

{1 :SmiteshP/nvim-navic
 :lazy false
 :opts {:highlight true
        :icons icons.kinds
        :lsp {:auto_attach true}
        :separator (.. " " icons.common.chevron_right " ")}}
