(import-macros {: command! : plugin! : custom-set-face!} :macros)

(local icons (require :icons))

(plugin! dmtrKovalenko/fff
 {:build #(let [download (require :fff.download)]
           (download:download_or_build_binary))
  :dependencies [:folke/snacks.nvim]
  :cmd [:FFFindFiles :FFFuzzySearch :FFFindOldFiles]
  :config (fn [_ opts]
           (let [fff (require :fff)]
            (fff.setup opts)
            (command! FFFindFiles `(fff.find_files {:title "Find Files"}))
            (command! FFFuzzySearch `(fff.live_grep {:title "Live Grep"}))
            (command! FFFindOldFiles (fn []) {:desc "Find Old Files"})
            ;; ToDo
            (custom-set-face! :FFFNormalTransparent [] {:bg :NONE})
            (custom-set-face! :FFFRed [] {:fg :red :bg :NONE})))
  :keys [[:<leader>. :<cmd>FFFindFiles<CR>] ["<leader>," :<cmd>FFFuzzySearch<CR>]]
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
         :prompt (.. " " icons.common.search "  ")
         :suggestions {:enabled false}
         :frecency {:enabled false}
         :git {:recency {:enabled false} :status_text_color true}
         :grep {:location_format "" :modes [:plain :regex :fuzzy] :trim_whitespace true}
         :history {:enabled false}
         :hl {:title :TelescopePromptTitle
              :winhl {:list "Normal:TelescopeNormal,FloatTitle:TelescopeResultsTitle,CursorLine:TelescopeSelection"
                      :preview "FloatTitle:TelescopePreviewTitle,Title:TelescopePreviewTitle"
                      :prompt "FloatTitle:TelescopePromptTitle,Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder"}
              :border :TelescopeBorder
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
              :file_info_value_dim :FFFRed
              :frecency :Number
              :git_deleted :DiffRemoved
              :git_ignored :FFFNormalTransparent
              :git_modified :FFFNormalTransparent
              :git_renamed :FFFNormalTransparent
              :git_staged :FFFNormalTransparent
              :git_untracked :FFFNormalTransparent
              ;;
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
              :suggestion_header :WarningMsg}}})
