(import-macros {: nil?} :macros)

(fn [{: format : enable-file-icon : readonly-icon : modified-icon}]
  (when (= nil format)
    (set-forcibly! format ":t"))
  (local FileName
         {:provider (fn [{: filename}]
                      (let [filename (vim.fn.fnamemodify filename format)]
                        (if (not= filename "")
                            (string.format " %s" filename))))})
  (local components [])
  (when enable-file-icon
    (table.insert components
                  {:init (fn [{: filename : extension &as self}]
                           (let [devicons (require "nvim-web-devicons")]
                             (set (self.icon self.icon-color)
                                  (devicons.get_icon_color filename extension))))
                   :provider (fn [{: icon}]
                               (if icon (.. icon " ")))
                   :hl (fn [{: icon-color}]
                         {:fg icon-color})}))
  (table.insert components FileName)
  (when readonly-icon
    (table.insert components
                  {:provider (.. " " readonly-icon)
                   :condition #(not (or vim.bo.modifiable vim.bo.readonly))}))
  (when modified-icon
    (table.insert components
                  {:provider (.. " " modified-icon)
                   :condition #vim.bo.modified}))
  (doto components
    (tset :init
          (fn [self]
            (set self.filename (vim.api.nvim_buf_get_name 0))
            (set self.extension (vim.fn.fnamemodify self.filename ":e"))))
    (tset :update ["BufEnter"
                   "BufWinEnter"
                   "BufModifiedSet"
                   "BufWritePost"
                   "OptionSet"])))
