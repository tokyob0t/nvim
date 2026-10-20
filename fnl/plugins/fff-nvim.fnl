(import-macros {: command! : custom-set-face!} :macros)

{1 :dmtrKovalenko/fff
 :build #(let [download (require :fff.download)]
           (download:download_or_build_binary))
 :init #(let [fff (require :fff)]
          (command! FFFindFiles `(fff.find_files {:title "Find Files"}))
          (command! FFFuzzySearch `(fff.live_grep {:title "Live Grep"}))
          ;; ToDo
          (command! FFFindOldFiles (fn []) {:desc "Find Old Files"})
          (custom-set-face! :FFFNormalTransparent [] {:bg :NONE}))
 :keys [[:<leader>. :<cmd>FFFindFiles<CR>]
        ["<leader>," :<cmd>FFFuzzySearch<CR>]]
 :lazy false
 :opts {:title "Find Files"
        :file_picker {:fuzzy_query_highlighting true}
        :layout {:anchor :center
                 :border :solid
                 :title_position :center
                 :width 0.87
                 :height 0.8
                 :filename_position :center
                 :preview_size 0.55
                 :prompt_position :top
                 :show_file_count false
                 :show_path_first true
                 :show_scrollbar true}
        :logging {:enabled false}
        :preview {:cursorlineopt :both :line_numbers false :wrap_lines false}
        :prompt "   "
        :suggestions {:enabled false}
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
             :file_info_label :TelescopeResultsTitle
             :file_info_match_type :TelescopeMatching
             :file_info_path :Directory
             :file_info_score_neg :DiagnosticError
             :file_info_score_pos :DiagnosticOk
             :file_info_section :TelescopePreviewTitle
             :file_info_separator :TelescopeBorder
             :file_info_size :Number
             :file_info_total_score :Bold
             :file_info_type :Type
             :file_info_value :TelescopeNormal
             :file_info_value_dim :Comment
             :frecency :Number
             :git_deleted :DiffRemoved
             :git_ignored :Comment
             :git_modified :DiffChanged
             :git_renamed :DiffChanged
             :git_sign_deleted :GitSignsDelete
             :git_sign_deleted_selected :TelescopeSelection
             :git_sign_ignored :Comment
             :git_sign_ignored_selected :TelescopeSelection
             :git_sign_modified :GitSignsChange
             :git_sign_modified_selected :TelescopeSelection
             :git_sign_renamed :GitSignsChange
             :git_sign_renamed_selected :TelescopeSelection
             :git_sign_staged :GitSignsAdd
             :git_sign_staged_selected :TelescopeSelection
             :git_sign_untracked :NonText
             :git_sign_untracked_selected :TelescopeSelection
             :git_staged :DiffAdded
             :git_untracked :NonText
             :grep_fuzzy_active :DiagnosticHint
             :grep_line_number :LineNr
             :grep_match :TelescopeMatching
             :grep_plain_active :Comment
             :grep_regex_active :DiagnosticInfo
             :matched :TelescopeMatching
             :normal :TelescopeNormal
             :prompt :TelescopePromptPrefix
             :scrollbar :TelescopeScrollbar
             :selected :TelescopeSelection
             :selected_active :TelescopeSelection
             :suggestion_header :WarningMsg
             :title :TelescopePromptTitle
             :winhl {:list "Normal:TelescopeNormal,FloatTitle:TelescopeResultsTitle,CursorLine:TelescopeSelection"
                     :preview "FloatTitle:TelescopePreviewTitle,Title:TelescopePreviewTitle"
                     :prompt "FloatTitle:TelescopePromptTitle,Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder"}}}}
