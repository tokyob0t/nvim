(import-macros {: let! : set!} :macros)

(local icons (require :icons))

(fn get-kind-icon-text [ctx]
  (let [devicons (require :nvim-web-devicons)]
    (when (vim.tbl_contains [:Path] ctx.source_name)
      (let [___antifnl_rtn_1___ (.. " "
                                    (tostring (devicons.get_icon ctx.label))
                                    (tostring ctx.icon_gap) " ")]
        (lua "return ___antifnl_rtn_1___")))
    (.. (tostring ctx.kind_icon) (tostring ctx.icon_gap))))

(fn get-kind-icon-highlight [ctx]
  (let [devicons (require :nvim-web-devicons)]
    (var hl ctx.kind_hl)
    (when (vim.tbl_contains [:Path] ctx.source_name)
      (local (dev-icon dev-hl) (devicons.get_icon ctx.label))
      (when dev-icon (set hl dev-hl)))
    hl))

{1 :saghen/blink.cmp
 :dependencies [:saghen/blink.lib
                :rafamadriz/friendly-snippets
                :nvim-tree/nvim-web-devicons]
 :init #(set! completeopt [:menu :menuone :noselect])
 :opts {:appearance {:kind_icons icons.kinds :nerd_font_variant :mono}
        :cmdline {:completion {:documentation {:auto_show true}
                               :ghost_text {:enabled true
                                            :show_without_selection true}
                               :list {:selection {:preselect false}}
                               :menu {:auto_show true}}
                  :enabled true
                  :keymap {:preset :inherit}
                  :sources {:default [:cmdline :buffer]}}
        :completion {:documentation {:auto_show true}
                     :ghost_text {:enabled true :show_without_selection true}
                     :list {:selection {:preselect false}}
                     :menu {:draw {:columns [[:kind_icon]
                                             {1 :label
                                              2 :source_name
                                              :gap 1
                                              :width 30}]
                                   :components {:kind_icon {:highlight get-kind-icon-highlight
                                                            :text get-kind-icon-text}
                                                :label {:text (fn [ctx]
                                                                ctx.label)
                                                        :width {:fill true
                                                                :max 30}}
                                                :source_name {:text (fn [ctx]
                                                                      (.. "["
                                                                          ctx.source_name
                                                                          "]"))
                                                              :width {:max 20}}}
                                   :padding [0 1]}}}
        :fuzzy {:implementation :lua}
        :keymap {:<S-Tab> [:select_prev :fallback]
                 :<Tab> [:select_next :fallback]
                 :preset :enter}
        :sources {:default [:lsp :path :snippets :buffer]}
        :term {:enabled false :keymap {:preset :inherit} :sources {}}}
 :opts_extend [:sources.default]}
