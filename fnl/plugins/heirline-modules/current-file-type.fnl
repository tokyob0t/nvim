(fn [...]
  {:provider #(.. vim.bo.filetype " ")
   :update [:BufEnter :BufWinEnter :BufModifiedSet :BufWritePost :OptionSet]})
