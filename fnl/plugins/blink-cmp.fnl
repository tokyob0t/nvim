(import-macros {: let! : set! : plugin!} :macros)

(local icons (require :icons))

(plugin! saghen/blink.cmp
 {:dependencies [:saghen/blink.lib :rafamadriz/friendly-snippets :nvim-tree/nvim-web-devicons :folke/snacks.nvim]
  :event [:InsertEnter :CmdlineEnter]
  :init (fn []
         (set! completeopt [:menu :menuone :noselect]))
  :opts_extend [:sources.default]
  :opts {:fuzzy {:implementation :lua}
         :sources {:default [:lsp :path :snippets :buffer]}
         :appearance {:kind_icons icons.kinds :nerd_font_variant :mono}
         :keymap {:preset :enter ;
                  :<S-Tab> [:select_prev :fallback]
                  :<Tab> [:select_next :fallback]}
         :term {:enabled false :keymap {:preset :inherit} :sources {}}
         :cmdline {:completion {:documentation {:auto_show true}
                                :ghost_text {:enabled true :show_without_selection true}
                                :list {:selection {:preselect false}}
                                :menu {:auto_show true}}
                   :enabled true
                   :keymap {:preset :inherit}
                   :sources {:default [:cmdline :buffer]}}
         :completion {:documentation {:auto_show true}
                      :ghost_text {:enabled true :show_without_selection true}
                      :list {:selection {:preselect false}}
                      :menu {:draw {:padding [0 1]
                                    :columns [[:kind_icon] {1 :label 2 :source_name :gap 1 :width 30}]
                                    :components {:kind_icon {:highlight #$.kind_hl
                                                             :text #(string.format "%s%s" $.kind_icon $.icon_gap)}
                                                 :label {:text #$.label :width {:fill true :max 30}}
                                                 :source_name {:text #(string.format "[%s]" $.source_name)
                                                               :width {:max 20}}}}}}}})
