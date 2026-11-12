(local icons (require :icons))

(let [cmdline-icon (.. icons.common.terminal " ")
      help-icon icons.common.help
      lua-icon icons.common.lua
      replace-icon icons.common.regex
      search-icon (.. icons.common.search " ")
      input-icon (.. icons.common.input " ")
      format {:cmdline {:pattern "^:" :icon cmdline-icon :lang :vim}
              :filter {:icon "$" :lang :bash :pattern "^:%s*!"}
              :help {:icon help-icon :pattern "^:%s*help%s+"}
              :input {:icon input-icon}
              :lua {:pattern "^:%s*lua%s+" :lang :lua :icon lua-icon}
              :replace {:icon replace-icon :lang :regex :pattern "^:%%s%/"}
              :search_down {:icon search-icon
                            :kind :search
                            :lang :regex
                            :pattern "^/"}
              :search_up {:icon search-icon
                          :kind :search
                          :lang :regex
                          :pattern "^%?"}}]
  {1 :folke/noice.nvim
   :event :VeryLazy
   :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
   :opts {:format {}
          :routes [{:filter {:event :notify :find :fewer} :opts {:skip true}}
                   {:filter {:event :notify :find :more} :opts {:skip true}}
                   {:filter {:event :notify :find :created} :opts {:skip true}}
                   {:filter {:event :notify :find :removed} :opts {:skip true}}
                   {:filter {:event :notify :find :clipboard}
                    :opts {:skip true}}]
          :cmdline {: format
                    :opts {:win_options {:winhighlight {:FloatBorder :FloatBorder
                                                        :Normal :NormalFloat}}}}
          :health {:checker false}
          :lsp {:progress {:enabled true}
                :override {:cmp.entry.get_documentation true
                           :vim.lsp.util.convert_input_to_markdown_lines true
                           :vim.lsp.util.stylize_markdown true}}
          ; :popupmenu {:backend :cmp}
          :presets {:long_message_to_split true :lsp_doc_border true}
          :views {:cmdline_popup {:position {:col "50%" :row 0}
                                  :size {:width "98%"}}}}})
