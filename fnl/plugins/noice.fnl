(local icons (require :icons))

{1 :folke/noice.nvim
 :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
 :event :VeryLazy
 :opts {:format {}
        :cmdline {:format {:cmdline {:icon (.. icons.common.terminal " ")
                                     :lang :vim
                                     :pattern "^:"}
                           :filter {:icon "$" :lang :bash :pattern "^:%s*!"}
                           :help {:icon icons.common.help
                                  :pattern "^:%s*help%s+"}
                           :input {:icon (.. icons.common.input " ")}
                           :lua {:icon icons.common.lua
                                 :lang :lua
                                 :pattern "^:%s*lua%s+"}
                           :replace {:icon icons.common.regex
                                     :lang :regex
                                     :pattern "^:%%s%/"}
                           :search_down {:icon (.. icons.common.search " ")
                                         :kind :search
                                         :lang :regex
                                         :pattern "^/"}
                           :search_up {:icon (.. icons.common.search " ")
                                       :kind :search
                                       :lang :regex
                                       :pattern "^%?"}}
                  :opts {:win_options {:winhighlight {:FloatBorder :FloatBorder
                                                      :Normal :NormalFloat}}}}
        :health {:checker false}
        :lsp {:override {:cmp.entry.get_documentation true
                         :vim.lsp.util.convert_input_to_markdown_lines true
                         :vim.lsp.util.stylize_markdown true}
              :progress {:enabled true}}
        :popupmenu {:backend :cmp}
        :presets {:long_message_to_split true :lsp_doc_border true}
        :views {:cmdline_popup {:position {:col "50%" :row 0}
                                :size {:width "98%"}}}}}
