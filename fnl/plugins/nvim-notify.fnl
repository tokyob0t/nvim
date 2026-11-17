(import-macros {: command! : custom-set-face! : plugin!} :macros)

(local default-titles [:Error :Warning :Notify])

(fn split-length [line width]
 (let [chunks []]
  (for [i 1 (length line) width]
   (table.insert chunks (line:sub i (math.min (+ i width -1) (length line)))))
  chunks))

(fn custom-wrap [lines max-width]
 (let [right-pad "  "
       wrapped []]
  (each [_ line (ipairs lines)]
   (each [_ chunk (ipairs (split-length line (- max-width (length right-pad))))]
    (table.insert wrapped (.. (chunk:gsub "^%s+" "") right-pad))))
  wrapped))

(fn render [bufnr notif highlights config]
 (let [base (require :notify.render.base)
       namespace (base.namespace)
       icon-length (length notif.icon)
       message (custom-wrap notif.message (or (config.max_width) 80))
       title (. notif.title 1)
       manual-title? (and (= (type title) :string) (< 0 (length title)) (not (vim.tbl_contains default-titles title)))]
  (var prefix "")
  (var prefix-length 0)
  (when manual-title?
   (set prefix (.. title " "))
   (when notif.duplicates
    (set prefix (.. prefix " x" (length notif.duplicates))))
   (set prefix-length (length prefix))
   (table.insert message 1 prefix))
  (tset message 1 (.. " " (. message 1)))
  (vim.api.nvim_buf_set_lines bufnr 0 -1 false message)
  (when manual-title?
   (vim.api.nvim_buf_set_extmark bufnr namespace 0 0
    {:end_col (+ icon-length 1) :hl_group highlights.icon :priority 50})
   (vim.api.nvim_buf_set_extmark bufnr namespace 0 (+ icon-length 1)
    {:end_col (+ prefix-length 1) :hl_group highlights.title :priority 50}))
  (vim.api.nvim_buf_set_extmark bufnr namespace 0 (+ prefix-length 1)
   {:end_line (length message) :hl_group highlights.body :priority 50})
  (for [ln 1 (length message)]
   (vim.api.nvim_buf_set_extmark bufnr namespace ln 0 {:virt_text [[" " highlights.body]] :virt_text_pos :inline})
   (vim.api.nvim_buf_set_extmark bufnr namespace ln 0 {:virt_text [[" " highlights.body]] :virt_text_pos :right_align}))))

(plugin! rcarriga/nvim-notify
 {:event [:VeryLazy :CmdlineEnter]
  :init (fn []
         (custom-set-face! :NotifyTRACETitle [] {:fg :red})
         (command! NotifyTest
          `(let [notify (require :notify)]
            (notify "prueba" "info" {:title "nvim-notify" :timeout 4000})) {:desc "Show a test notification"}))
  :opts {}})
