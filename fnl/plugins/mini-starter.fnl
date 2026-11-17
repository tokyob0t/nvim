(import-macros {: plugin!} :macros)

(local icons (require :icons))

;; same braille header as the alpha dashboard
(local art ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
            "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
            "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
            "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
            "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
            "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
            "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
            " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
            " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
            "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
            "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "])

(local header-text (table.concat art "\n"))

;; label on the left, shortcut right-aligned like the alpha buttons did
(fn entry [icon label shortcut action]
 (let [text (.. icon "  " label)
       pad (math.max 2 (- 30 (vim.fn.strdisplaywidth text)))]
  {: action :name (.. text (string.rep " " pad) shortcut) :section ""}))

(fn summary []
 ((. (require :modules.profile) :summary)))

(plugin! echasnovski/mini.starter
 {:event :VimEnter
  :config (fn []
           (let [starter (require :mini.starter)
                 opts {:autoopen false
                       :header header-text
                       :footer summary
                       ;; aligning centers both axes; the default hooks would
                       ;; put a bullet in front of every item
                       :content_hooks [(starter.gen_hook.aligning :center :center)]
                       :items [(entry icons.common.search "Find Files" "SPC ." #(vim.cmd.FFFindFiles))
                               (entry icons.common.regex "Find Word" "SPC ," #(vim.cmd.FFFuzzySearch))
                               (entry icons.common.lazy "Lazy" "SPC l" #(vim.cmd.Lazy))
                               (entry icons.common.plugin "Mason" "SPC m" #(vim.cmd.Mason))]}]
            (starter.setup opts)
            (vim.api.nvim_set_hl 0 :MiniStarterHeader {:link :Comment})
            (vim.api.nvim_set_hl 0 :MiniStarterFooter {:link :Comment})
            (when (and (= 0 (vim.fn.argc)) (= "" (vim.fn.expand "%")))
             (starter.open))))})
