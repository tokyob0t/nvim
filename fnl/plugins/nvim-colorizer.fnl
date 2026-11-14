(import-macros {: plugin!} :macros)

(plugin! catgoose/nvim-colorizer.lua
 {:event :BufReadPre
  :opts {:lazy_load true
         :user_commands false
         :options {:display {:mode :background :virtualtext {:hl_mode :background}}}}})
