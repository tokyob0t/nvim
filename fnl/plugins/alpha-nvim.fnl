(import-macros {: plugin!} :macros)

(local icons (require :icons))

(fn button [label sc ?keybind]
 (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)]
  {:type :button
   :val label
   :opts {:align_shortcut :right
          :cursor 5
          :hl :AlphaButtons
          :keymap (if ?keybind
                      [:n sc- ?keybind {:noremap true :silent true}])
          :position :center
          :shortcut sc
          :text label
          :width 36}
   :on_press #(let [key (vim.api.nvim_replace_termcodes sc- true false true)]
               (vim.api.nvim_feedkeys key :normal false))}))

(local default
 {:ascii ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
          "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
          "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
          "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
          "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
          "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
          "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
          " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
          " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
          "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
          "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "]})

(set default.header {:opts {:hl :Comment :position :center} :type :text :val default.ascii})

(set default.buttons
 {:opts {:spacing 1}
  :type :group
  :val [(button (.. icons.common.search "  Find Files ") "    SPC ." :<cmd>FFFindFiles<CR>)
        (button (.. icons.common.regex "  Find Word  ") "    SPC ," :<cmd>FFFuzzySearch<CR>)
        (button (.. icons.common.lazy "  Lazy") "SPC l" :<cmd>Lazy<CR>)
        (button (.. icons.common.plugin "  Mason  ") "SPC m" :<cmd>Mason<CR>)]})

(plugin! goolord/alpha-nvim
 {:event :VimEnter
  :config #(let [profile (require :modules.profile)
                 alpha (require :alpha)
                 header-height (length default.ascii)
                 button-count (length default.buttons.val)
                 button-spacing (or default.buttons.opts.spacing 0)
                 buttons-height (+ button-count (* (- button-count 1) button-spacing))
                 total-height (+ header-height 2 buttons-height 2)
                 header-padding (math.max 2 (math.floor (/ (- (vim.fn.winheight 0) total-height) 2)))]
            (alpha.setup {:opts {:margin 5}
                          :layout [{:type :padding :val header-padding}
                                   default.header
                                   {:type :padding :val 2}
                                   default.buttons
                                   {:type :padding :val 1}
                                   {:type :text :opts {:hl :Comment :position :center} :val (profile.summary)}]}))})
