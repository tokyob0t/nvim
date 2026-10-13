(local icons (require :icons))

(fn button [txt sc keybind]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)]
    {:on_press (fn []
                 (local key
                        (vim.api.nvim_replace_termcodes sc- true false true))
                 (vim.api.nvim_feedkeys key :normal false))
     :opts {:align_shortcut :right
            :cursor 5
            :hl :AlphaButtons
            :keymap (and keybind [:n sc- keybind {:noremap true :silent true}])
            :position :center
            :shortcut sc
            :text txt
            :width 36}
     :type :button
     :val txt}))

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

(set default.header {:opts {:hl :Comment :position :center}
                     :type :text
                     :val default.ascii})

(set default.buttons
     {:opts {:spacing 1}
      :type :group
      :val [(button (.. icons.common.search "  Find Files ") "    SPC ."
                    :<cmd>FFFindFiles<CR>)
            (button (.. icons.common.word "  Find Word  ") "    SPC ,"
                    :<cmd>FFFuzzySearch<CR>)
            (button (.. icons.common.lua "  Lazy") "SPC l" :<cmd>Lazy<CR>)
            (button (.. icons.common.plugin "  Mason  ") "SPC m"
                    :<cmd>Mason<CR>)]})

(fn get-padding [content-height]
  (math.max 2 (math.floor (/ (- (vim.fn.winheight 0) content-height) 2))))

(local header-height (length default.ascii))
(local button-count (length default.buttons.val))
(local button-spacing (or default.buttons.opts.spacing 0))
(local buttons-height (+ button-count (* (- button-count 1) button-spacing)))
(local total-height (+ header-height 2 buttons-height))
(local header-padding (get-padding total-height))

{1 :goolord/alpha-nvim
 :dependencies [:dmtrKovalenko/fff]
 :event :VimEnter
 :opts {:opts {:margin 5}
        :layout [{:type :padding :val header-padding}
                 default.header
                 {:type :padding :val 2}
                 default.buttons]}}
