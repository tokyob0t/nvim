(local Icons (require :icons))

{[1] :nvim-telescope/telescope.nvim
 :dependencies [{[1] :nvim-lua/plenary.nvim}
                {[1] :nvim-telescope/telescope-fzf-native.nvim :build :make}]
 :keys [{1 :<leader>. 2 :<cmd>Telescope find_files<CR>}
        {1 :<leader><Tab>. 2 :<cmd>Telescope oldfiles<CR>}
        {1 :<leader>, 2 :<cmd>Telescope live_grep<CR>}
        {1 :<leader><Tab>, 2 :<cmd>Telescope marks<CR>}
        {1 :<leader>k 2 :<cmd>Telescope keymaps<CR>}]
 :opts {:defaults {:prompt_prefix (.. " " (. Icons.common :search) "  ")
                   :selection_caret "  "
                   :entry_prefix "  "
                   :sorting_strategy :ascending
                   :layout_strategy :flex
                   :set_env {:COLORTERM :truecolor}
                   :dynamic_preview_title true
                   :layout_config {:width 0.87
                                   :height 0.8
                                   :preview_cutoff 120
                                   :vertical {:mirror false}
                                   :horizontal {:prompt_position :top
                                                :preview_width 0.55}}}
        :pickers {:oldfiles {:prompt_title "Recent Files"}}}}
