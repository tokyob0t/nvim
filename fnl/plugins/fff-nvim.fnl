(local create-user-command vim.api.nvim_create_user_command)

{1 :dmtrKovalenko/fff
 :build #(let [download (require :fff.download)]
           (download:download_or_build_binary))
 :init #(let [fff (require :fff)]
          (vim.api.nvim_set_hl 0 :NormalTransparent
                               {:bg :NONE
                                :fg (. (vim.api.nvim_get_hl 0 {:name :Normal})
                                       :fg)})
          (create-user-command :FFFindFiles
                               #(fff.find_files {:title "Find Files"})
                               {:desc :FFFindFiles})
          (create-user-command :FFFindOldFiles #nil {:desc :FFFindOldFiles})
          (create-user-command :FFFuzzySearch
                               #(fff.live_grep {:title "Live Grep"})
                               {:desc :FFFindFiles}))
 :keys [[:<leader>. :<cmd>FFFindFiles<cr>]
        ["<leader>," :<cmd>FFFuzzySearch<cr>]]
 :lazy false
 :opts {:file_picker {:fuzzy_query_highlighting true}
        :frecency {:enabled false}
        :git {:recency {:enabled false} :status_text_color true}
        :grep {:location_format ""
               :modes [:plain :regex :fuzzy]
               :trim_whitespace true}
        :history {:enabled false}
        :hl {:border :TelescopeBorder
             :combo_header :NormalTransparent
             :cursor :TelescopeSelection
             :debug :NormalTransparent
             :directory_path :NormalTransparent
             :frecency :Number
             :git_deleted :DiffRemoved
             :git_ignored :Comment
             :git_modified :DiffChanged
             :git_renamed :DiffChanged
             :git_staged :DiffAdded
             :git_untracked :NonText
             :matched :TelescopeMatching
             :normal :TelescopeNormal
             :prompt :TelescopePromptPrefix
             :scrollbar :TelescopeScrollbar
             :selected :TelescopeSelection
             :selected_active :TelescopeSelection
             :suggestion_header :WarningMsg
             :title :TelescopePromptTitle
             :winhl {:preview "Normal:TelescopePreviewNormal,Title:TelescopePreviewTitle,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle"
                     :prompt "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,FloatTitle:TelescopePromptTitle"}}
        :layout {:anchor :center
                 :border :solid
                 :filename_position :center
                 :height 0.8
                 :preview_size 0.55
                 :prompt_position :top
                 :show_file_count false
                 :show_path_first true
                 :show_scrollbar true
                 :title_position :center
                 :width 0.87}
        :logging {:enabled false}
        :preview {:cursorlineopt :both :line_numbers false :wrap_lines false}
        :prompt "   "
        :suggestions {:enabled false}
        :title "Find Files"}}
