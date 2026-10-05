(local Icons (require :icons))
(fn button [sc text keybind]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)]
    {:type :button
     :val text
     :on_press #(let [key (vim.api.nvim_replace_termcodes sc- true false true)]
                  (vim.api.nvim_feedkeys key :normal false))
     :opts {: text
            :align_shortcut :right
            :cursor 5
            :hl :AlphaButtons
            :keymap (if keybind
                        [:n sc- keybind {:noremap true :silent true}])
            :position :center
            :shortcut sc
            :width 36}}))

(local default
       (let [ascii ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
                    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
                    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
                    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
                    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
                    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
                    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
                    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
                    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
                    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
                    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "]]
         {: ascii
          :header {:opts {:hl :Comment :position :center}
                   :type :text
                   :val ascii}
          :buttons {:opts {:spacing 1}
                    :type :group
                    :val [(button "    SPC ."
                                  (.. Icons.common.search "  Find File  ")
                                  ":Telescope find_files<CR>")
                          (button "    SPC ,"
                                  (.. Icons.common.word "  Find Word  ")
                                  ":Telescope live_grep<CR>")
                          (button "SPC TAB ."
                                  (.. Icons.common.recent "  Recent File  ")
                                  ":Telescope oldfiles<CR>")
                          (button "SPC TAB ,"
                                  (.. Icons.common.bookmark "  Bookmarks  ")
                                  ":Telescope marks<CR>")
                          (button "    SPC k"
                                  (.. Icons.common.keymap "  Keymaps")
                                  ":Telescope keymaps<CR>")]}}))

(fn get-padding [content-height]
  (math.max 2 (math.floor (/ (- (vim.fn.winheight 0) content-height) 2))))

(local header-height (length default.ascii))
(local button-count (length default.buttons.val))
(local button-spacing (or default.buttons.opts.spacing 0))
(local buttons-height (+ button-count (* (- button-count 1) button-spacing)))
(local total-height (+ header-height 2 buttons-height))
(local header-padding (get-padding total-height))

{1 :goolord/alpha-nvim
 :dependencies [:nvim-telescope/telescope.nvim]
 :event :VimEnter
 :opts {:layout [{:type :padding :val header-padding}
                 default.header
                 {:type :padding :val 2}
                 default.buttons]
        :opts {:margin 5}}}
