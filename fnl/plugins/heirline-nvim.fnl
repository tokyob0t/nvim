(import-macros {: set! : plugin! : autocmd! : bool?} :macros)

(local icons (require :icons))
(local vim-mode (require :vim-mode))
(local vim-mode-highlights (require :vim-mode-highlights))

(local Severity vim.diagnostic.severity)

(local EXCLUDED_BUFTYPES [:nofile :prompt :help :quickfix])

(local EXCLUDED_FILETYPES [:NvimTree.*
                           :Telescope.*
                           :dashboard
                           ;;"[Aa]lpha"
                           :^git.*
                           :fugitive
                           :Trouble
                           :dashboard])

;; tabline components

(fn offset []
 {:condition (fn [self]
              (local win (-> (vim.api.nvim_tabpage_list_wins 0)
                             (. 1)))
              (when (not win)
               (lua "return false"))
              (local bufnr (vim.api.nvim_win_get_buf win))
              (when (not (vim.api.nvim_buf_is_valid bufnr))
               (lua "return false"))
              (local nvim-tree? (= (. vim.bo bufnr :filetype) :NvimTree))
              (when (not nvim-tree?)
               (lua "return false"))
              (set self.winid win)
              true)
  :hl :TabLineSel
  :provider (fn [self]
             (local title :Files)
             (local width (vim.api.nvim_win_get_width self.winid))
             (local pad (math.max 0 (math.ceil (/ (- width (length title)) 2))))
             (.. (string.rep " " pad) title (string.rep " " pad)))})

(fn buffers []
 (let [{: pathshorten : fnamemodify : bufname} vim.fn]
  {:init (fn [{: bufferline &as self}]
          (let [{: make_buflist} (require :heirline.utils)]
           (set self.bufferlines (self:new (make_buflist bufferline) 1))))
   :provider (fn [{: bufferlines}] (bufferlines:eval))
   :static {:bufferline {:init (fn [{: bufnr &as self}]
                                (set self.filename (pathshorten (fnamemodify (bufname bufnr) ":.")))
                                (when (= self.filename "")
                                 (set self.lfilename "No Name")))
                         :hl (fn [{: is_active}]
                              (if is_active :TabLineSel :TabLine))
                         1 {:provider #(.. " [" $.filename "] ")
                            :hl (fn [{: is_active : is_visible}]
                                 {:bold (or is_active is_visible)})}
                         2 {:provider (.. icons.tree.git.untracked "  ")
                            :condition (fn [{: bufnr}]
                                        (. vim.bo bufnr :modified))}}}}))

;; winbar components

;; only ask for navic and devicons when there is something to show: reading
;; package.loaded.vim.lsp avoids pulling vim.lsp in on the dashboard
(fn lsp-clients? []
 (let [lsp (. package.loaded :vim.lsp)
       clients (if lsp (lsp.get_clients {:bufnr 0}) [])]
  (> (length clients) 0)))

(fn navic []
 (doto {:init (fn [self]
               (let [filename (vim.fn.expand "%:t")
                     extension (vim.fn.fnamemodify filename ":e")]
                (set [self.filename self.extension] [filename extension])
                (when (not= filename "")
                 (let [devicons (require :nvim-web-devicons)]
                  (set (self.icon self.icon-color) (devicons.get_icon_color filename extension))))))
        :hl "Normal"}
  (tset 1 {:hl (fn [{: icon-color}] {:fg icon-color})
           :provider (fn [{: icon}]
                      (if icon (.. icon " ")))})
  (tset 2 {:hl "Normal"
           :provider (fn [{: filename}]
                      (if (not= filename "") (.. filename " ")))})
  (tset 3 {:hl "NavicSeparator"
           :update "CursorMoved"
           :provider (.. icons.common.chevron_right " ")
           :condition #(let [navic (if (lsp-clients?) (require :nvim-navic))
                             available? (if navic (navic.is_available))
                             location (if available? (navic.get_location))]
                        (and available? (> (length location) 0)))})
  (tset 4 {:update "CursorMoved"
           :provider #(let [navic (if (lsp-clients?) (require :nvim-navic))]
                       (if navic (navic.get_location {:highlight true})))
           :condition #(let [navic (if (lsp-clients?) (require :nvim-navic))
                             available? (if navic (navic.is_available))]
                        available?)})))

;; statusline components

(fn mode [...]
 (let [{: redrawstatus} vim.cmd]
  {:init (fn [self]
          (let [{: mode} (vim.api.nvim_get_mode)]
           (set self.mode mode)))
   :hl (fn [{: mode}]
        (. vim-mode-highlights mode))
   :provider (fn [{: mode}]
              (.. " " (. vim-mode mode) " "))
   :update (doto [:ModeChanged]
            (tset :pattern "*:*")
            (tset :callback (fn [self]
                             (let [{: mode} (vim.api.nvim_get_mode)]
                              (set self.mode mode)
                              (redrawstatus)))))}))

(fn fileinfo []
 {:init (fn [self]
         (let [in-a-file? (not= (vim.fn.expand "%") "")
               filename (vim.fn.expand "%:t")]
          (set [self.in-a-file? self.filename] [in-a-file? filename])))
  :update [:BufEnter :BufWinEnter :BufModifiedSet :BufWritePost :OptionSet]
  :highlight :Normal
  :provider (fn [{: in-a-file? : filename}]
             (if in-a-file?
                 (.. " " filename)))})

(fn git-branch [{: format}]
 (when (not format)
  (set-forcibly! format "#%s"))
 {:init (fn [self]
         (set self.git-status vim.b.gitsigns_status_dict))
  :condition #(let [{: is_git_repo} (require :heirline.conditions)]
               (is_git_repo))
  :hl {:bold true}
  :provider (fn [{: git-status}]
             (if git-status.head
                 (.. " " (string.format format git-status.head))))
  :update (doto [:BufEnter :User]
           (tset :pattern [:GitSignsUpdate :GitSignsChanged]))})

(fn filetype []
 {:provider #(.. vim.bo.filetype " ")
  :hl :NormalNC
  :update [:BufEnter :BufWinEnter :BufModifiedSet :BufWritePost :OptionSet]})

(fn diagnostics []
 (let [get-severity #(length (vim.diagnostic.get 0 {:severity $}))]
  (doto {:init (fn [self]
                (set self.errors (get-severity Severity.ERROR))
                (set self.warnings (get-severity Severity.WARN)))
         :update [:DiagnosticChanged :BufEnter]
         ; :condition #(let [{: has_diagnostics} (require :heirline.conditions)]
         ;              (has_diagnostics))
         }
   (tset 1 {:hl :StatusLineDiagnosticWarn
            :provider (fn [{: warnings}]
                       (string.format "%s " warnings))})
   (tset 2 {:hl :StatusLineDiagnosticError
            :provider (fn [{: errors}]
                       (string.format "%s " errors))}))))

(fn cursor-position []
 (fn matches-label [count]
  (let [total (if (> count.total count.maxcount)
                  (.. ">" count.maxcount)
                  count.total)]
   (.. total " matches")))

 (fn search-count []
  (let [(ok? count) (pcall vim.fn.searchcount {:recompute true})]
   (when (and ok? (= (type count) :table) (not= count.current nil) (> count.total 0))
    (if (= count.incomplete 1)
        "?/?"
        (matches-label count)))))

 {:init (fn [self]
         (set self.search-count (if (not (= vim.v.hlsearch 0))
                                    (search-count))))
  :provider (fn [{: search-count}]
             (or search-count "%l:%c"))
  :hl :Normal
  :update [:CursorMoved :CursorMovedI :CmdlineLeave :BufEnter]})

(fn Bar [{: excluded-filetypes : excluded-buftypes} ...]
 (doto [...]
  (tset :static {:excluded_filetypes excluded-filetypes})
  (tset :condition
   (if (or excluded-filetypes excluded-buftypes)
       (fn [{: excluded_filetypes}]
        (let [{: buffer_matches} (require :heirline.conditions)]
         (not (buffer_matches {:filetype excluded_filetypes :buftype excluded-buftypes}))))))))

(plugin! rebelot/heirline.nvim
 {:event :UiEnter
  :init #(let [redrawtabline (vim.schedule_wrap vim.cmd.redrawtabline)
               count-buffers #(length (icollect [_ buf (ipairs (vim.api.nvim_list_bufs))]
                                       (if (. vim.bo buf :buflisted)
                                           buf)))]
          (set! showtabline 0)
          (autocmd! [BufEnter TabEnter BufAdd BufDelete BufModifiedSet BufWritePost] *
           `(do
             (set! showtabline (if (>= (count-buffers) 2) 2 0))
             (redrawtabline))))
  :opts {:tabline (Bar {}   ;
                   (offset) ;
                   (buffers))
         :winbar (Bar {:excluded-filetypes EXCLUDED_FILETYPES} ;
                  {:provider "     "}                          ;
                  (navic))
         :statusline (Bar {:excluded-filetypes EXCLUDED_FILETYPES} ;
                      (mode)                                       ; 
                      (fileinfo)                                   ;
                      (git-branch {:format "(λ • #%s)"})        ;
                      {:provider "%="}                             ;
                      (diagnostics)                                ;
                      (filetype)                                   ;
                      (cursor-position))
         :opts {:disable_winbar_cb (fn [{: buf}]
                                    (let [{: buffer_matches} (require :heirline.conditions)]
                                     (buffer_matches {:buftype EXCLUDED_BUFTYPES :filetype EXCLUDED_FILETYPES} buf)))}}})
