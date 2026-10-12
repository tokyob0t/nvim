(local icons (require :icons))
(local mode-names {"\019" :SL
                   "\022" "**"
                   "\022s" "**"
                   :! "!"
                   :R :RA
                   :Rc :RA
                   :Rv :RV
                   :Rvc :RV
                   :Rvx :RV
                   :Rx :RA
                   :S :SL
                   :V "**"
                   :Vs "**"
                   :c :VIEX
                   :cv :VIEX
                   :i "**"
                   :ic "**"
                   :ix "**"
                   :n :RW
                   :niI :RW
                   :niR :RW
                   :niV :RW
                   :no :RO
                   "no\022" :RO
                   :noV :RO
                   :nov :RO
                   :nt :RW
                   :r :r
                   :r? :r
                   :rm :r
                   :s :S
                   :t icons.common.terminal
                   :v "**"
                   :vs "**"})

(local mode-groups {"\019" :visual
                    "\022" :visual
                    "\022s" :visual
                    :! :normal
                    :R :replace
                    :Rc :replace
                    :Rv :replace
                    :Rvc :replace
                    :Rvx :replace
                    :Rx :replace
                    :S :visual
                    :V :visual
                    :Vs :visual
                    :c :command
                    :cv :command
                    :i :insert
                    :ic :insert
                    :ix :insert
                    :n :normal
                    :niI :normal
                    :niR :normal
                    :niV :normal
                    :no :normal
                    "no\022" :normal
                    :noV :normal
                    :nov :normal
                    :nt :normal
                    :r :normal
                    :r? :normal
                    :rm :normal
                    :s :visual
                    :t :normal
                    :v :visual
                    :vs :visual})

(fn string.capitalize [s]
  (s:gsub "^%l" string.upper))

(fn [...]
  {:init (fn [self]
           (set self.mode (vim.fn.mode 1)))
   :provider (fn [self]
               (.. "%2( " (. self.mode_names self.mode) " %)"))
   :static {:mode_groups mode-groups :mode_names mode-names}
   :update {1 :ModeChanged
            :callback (vim.schedule_wrap #(vim.cmd :redrawstatus))
            :pattern "*:*"}
   :hl (fn [self]
         (local group (or (. self.mode_groups self.mode) :normal))
         (.. :Status (string.capitalize group)))})
