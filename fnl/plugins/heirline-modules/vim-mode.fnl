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

(local mode-groups {"\019" :StatusVisual
                    "\022" :StatusVisual
                    "\022s" :StatusVisual
                    :! :StatusNormal
                    :R :StatusReplace
                    :Rc :StatusReplace
                    :Rv :StatusReplace
                    :Rvc :StatusReplace
                    :Rvx :StatusReplace
                    :Rx :StatusReplace
                    :S :StatusVisual
                    :V :StatusVisual
                    :Vs :StatusVisual
                    :c :StatusCommand
                    :cv :StatusCommand
                    :i :StatusInsert
                    :ic :StatusInsert
                    :ix :StatusInsert
                    :n :StatusNormal
                    :niI :StatusNormal
                    :niR :StatusNormal
                    :niV :StatusNormal
                    :no :StatusNormal
                    "no\022" :StatusNormal
                    :noV :StatusNormal
                    :nov :StatusNormal
                    :nt :StatusNormal
                    :r :StatusNormal
                    :r? :StatusNormal
                    :rm :StatusNormal
                    :s :StatusVisual
                    :t :StatusNormal
                    :v :StatusVisual
                    :vs :StatusVisual})

(fn [...]
  {:init (fn [self]
           (set self.mode (vim.fn.mode 1)))
   :update {1 :ModeChanged
            :pattern "*:*"
            :callback (vim.schedule_wrap #(vim.cmd :redrawstatus))}
   :provider (fn [{: mode-names : mode}]
               (.. "%2( " (. mode-names mode) " %)"))
   :static {: mode-groups : mode-names}
   :hl (fn [{: mode-groups : mode}]
         (or (?. mode-groups mode) :StatusNormal))})
