(local Icons (require :icons))
(local options vim.opt)

(fn getKindIconText [ctx]
  (local devicons (require :nvim-web-devicons))
  (if (vim.tbl_contains [:Path] ctx.source_name)
      (.. " " (tostring (devicons.get_icon ctx.label)) (tostring ctx.icon_gap)
          " ")
      (.. (tostring ctx.kind_icon) (tostring ctx.icon_gap))))

(fn getKindIconHighlight [ctx]
  (local devicons (require :nvim-web-devicons))
  (var hl ctx.kind_hl)
  (if (vim.tbl_contains [:Path] ctx.source_name)
      (let [(dev_icon dev_hl) (devicons.get_icon ctx.label)]
        (when dev_icon
          (set hl dev_hl))))
  hl)

{1 :saghen/blink.cmp
 :dependencies [:saghen/blink.lib
                :rafamadriz/friendly-snippets
                :nvim-tree/nvim-web-devicons]
 :init #(do
          (set options.completeopt [:menu :menuone :noselect]))
 :opts_extend [:sources.default]
 :opts {:keymap {:preset :enter
                 :<Tab> [:select_next :fallback]
                 :<S-Tab> [:select_prev :fallback]}
        :appearance {:nerd_font_variant :mono :kind_icons Icons.kinds}
        :sources {:default [:lsp :path :snippets :buffer]}
        :fuzzy {:implementation :lua}
        :completion {:documentation {:auto_show true}
                     :ghost_text {:enabled true :show_without_selection true}
                     :list {:selection {:preselect false}}
                     :menu {:draw {:padding [0 1]
                                   :columns [[:kind_icon]
                                             {:gap 1
                                              :width 30
                                              :label :source_name}]
                                   :components {:kind_icon {:text getKindIconText
                                                            :highlight getKindIconHighlight}
                                                :label {:width {:fill true
                                                                :max 30}
                                                        :text (fn [ctx]
                                                                ctx.label)}
                                                :source_name {:width {:max 20}
                                                              :text (fn [ctx]
                                                                      (.. "["
                                                                          ctx.source_name
                                                                          "]"))}}}}}
        :cmdline {:enabled true
                  :keymap {:preset :inherit}
                  :sources {:default [:cmdline :buffer]}
                  :completion {:list {:selection {:preselect false}}
                               :menu {:auto_show true}
                               :ghost_text {:enabled true
                                            :show_without_selection true}
                               :documentation {:auto_show true}}}
        :term {:enabled false :keymap {:preset :inherit} :sources {}}}}
