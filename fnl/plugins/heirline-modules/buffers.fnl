(local icons (require :icons))

(fn TablineOffset [{: title}]
  {:condition (fn [self]
                (local win (. (vim.api.nvim_tabpage_list_wins 0) 1))
                (when (not win) (lua "return false"))
                (local bufnr (vim.api.nvim_win_get_buf win))
                (if (not (vim.api.nvim_buf_is_valid bufnr))
                    (lua "return false")
                    (= (. vim.bo bufnr :filetype) :NvimTree)
                    (do
                      (set self.winid win)
                      (lua "return true")))
                false)
   :hl #(let [{: winid} $]
          (if (= (. (vim.api.nvim_tabpage_list_wins 0) 1) winid)
              :TabLineSel
              :TabLine))
   :provider #(let [{: winid} $
                    width (vim.api.nvim_win_get_width winid)
                    pad (math.max 0 (math.ceil (/ (- width (length title)) 2)))]
                (.. (string.rep " " pad) title (string.rep " " pad)))})

(fn ReadonlyFlag [{: readonly_icon}]
  (if readonly_icon
      {:condition (fn []
                    (or (not vim.bo.modifiable) vim.bo.readonly))
       :provider (.. args.readonly_icon " ")}))

(fn ModifiedFlag [{: modified_icon}]
  (if modified_icon
      {:condition (fn [self]
                    (vim.api.nvim_get_option_value :modified {:buf self.bufnr}))
       :provider (.. modified_icon " ")}))

(fn TablineFile []
  {:hl (fn [self]
         {:bold (or self.is_active self.is_visible)})
   :init (fn [{: filename &as self}]
           (set self.lfilename
                (vim.fn.pathshorten (vim.fn.fnamemodify filename ":.")))
           (when (= self.lfilename "")
             (set self.lfilename "No Name")))
   :provider (fn [{: lfilename}] (.. "[" lfilename "]"))})

(fn BufferLine []
  {:init #(let [self $
                utils (require :heirline.utils)
                bufferline (utils:make_buflist Tabline-file-name-block)]
            (set self.bufferline (self:new bufferline 1)))
   :provider (fn [{: bufferline}]
               (bufferline:eval))})

(fn [args]
  (let [Tabline-file-name-block {1 (TablineFile)
                                 2 (ReadonlyFlag)
                                 3 (ModifiedFlag)
                                 :hl (fn [self]
                                       (if self.is_active :TabLineSel
                                           :TabLine))
                                 :init (fn [{: bufnr &as self}]
                                         (set self.filename
                                              (vim.api.nvim_buf_get_name bufnr)))
                                 :on_click {:callback (vim.schedule_wrap (fn [_
                                                                              minwid
                                                                              _
                                                                              button]
                                                                           (if (= button
                                                                                  :m)
                                                                               (do
                                                                                 (vim.api.nvim_buf_delete minwid
                                                                                                          {:force false})
                                                                                 (vim.cmd.redrawtabline))
                                                                               (vim.api.nvim_win_set_buf 0
                                                                                                         minwid))))
                                            :minwid (fn [self] self.bufnr)
                                            :name :heirline_tabline_buffer_callback}}]
    [(TablineOffset {:title :Files}) BufferLine]))
