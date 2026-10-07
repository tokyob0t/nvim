(fn FileIcon [file-icon]
  (if file-icon {:init #(let [self $
                              devicons (require :nvim-web-devicons)]
                          (set [self.icon self.icon_color]
                               (devicons.get_icon_color self.filename
                                                        self.extension)))
                 :provider (fn [self]
                             (if self.icon (.. self.icon " ")))
                 :hl (fn [{: icon_color}]
                       {:fg icon_color})}))

(fn FileName [filename format]
  {:provider (fn [self]
               (let [filename (vim.fn.fnamemodify self.filename format)]
                 (if (not= filename "")
                     (string.format " %s " filename))))})

(fn ModifiedFlag [modified_icon]
  (if modified_icon
      {:condition #vim.bo.modified :provider (.. modified_icon " ")}))

(fn ReadonlyFlag [readonly-icon]
  (if readonly-icon
      {:provider (.. readonly-icon " ")
       :condition #(not (or vim.bo.modifiable vim.bo.readonly))}))

(fn [{: format : enable-file-icon : readonly-icon : modified-icon}]
  (let [format (or format ":t")
        EVENTS [:BufEnter
                :BufWinEnter
                :BufModifiedSet
                :BufWritePost
                :OptionSet]]
    {:update EVENTS
     :init (fn [self]
             (set self.filename (vim.api.nvim_buf_get_name 0))
             (set self.extension (vim.fn.fnamemodify self.filename ":e")))
     [1] (FileIcon enable-file-icon)
     [2] (FileName nil format)
     [3] (ReadonlyFlag readonly-icon)
     [4] (ModifiedFlag modified-icon)}))
