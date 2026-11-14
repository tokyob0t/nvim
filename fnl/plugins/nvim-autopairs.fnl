(import-macros {: plugin!} :macros)

(plugin! windwp/nvim-autopairs
 {:event :InsertEnter :opts {:disable_filetype [:TelescopePrompt :vim]}})
