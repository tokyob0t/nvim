(fn [...]
  {:provider (fn [] (.. " " vim.bo.filetype " "))
   :update [:BufEnter :BufWinEnter :BufModifiedSet :BufWritePost :OptionSet]})
