;; Startup profiling: wall-clock cost of each config module plus the total,
;; surfaced on the alpha dashboard and through :StartupTime.
(local uv (or vim.uv vim.loop))

(local times [])
(local by-name {})

(fn now [] (/ (uv.hrtime) 1e6))

(fn time! [name f]
 (let [start (now)
       (ok? res) (pcall f)
       elapsed (- (now) start)]
  (tset by-name name elapsed)
  (table.insert times {:name name :ms elapsed})
  (if ok? res (error res))))

(fn elapsed []
 (let [t0 (. vim.g :startup_t0)]
  (if t0 (- (now) (/ t0 1e6)))))

;; freeze the total at VimEnter so :StartupTime keeps reporting startup and
;; not however long the session has been open
(var total-ms nil)

(vim.api.nvim_create_autocmd :VimEnter {:callback (fn [] (set total-ms (elapsed)))})

(fn total [] (or total-ms (elapsed)))

(fn counts []
 (let [(ok? lazy) (pcall require :lazy)
       (ok? stats) (if ok? (pcall (fn [] (lazy.stats))) false)]
  {:total (if ok? stats.count 0) :loaded (if ok? stats.loaded 0)}))

(fn summary []
 (let [c (counts)]
  (string.format "loaded %d of %d plugins across %d modules in %.1f ms" c.loaded c.total (length times) (or (total) 0))))

(fn loaded-ms [plugin]
 (let [loaded (and (. plugin :_) (. plugin :_ :loaded))]
  (if (and loaded loaded.time) (/ loaded.time 1e6))))

(fn slow-plugins [n]
 (let [(ok? config) (pcall require :lazy.core.config)
       items (if ok?
                 (icollect [name plugin (pairs config.plugins)]
                  (let [ms (loaded-ms plugin)]
                   (if ms {:name name :ms ms})))
                 [])]
  (table.sort items (fn [a b] (> a.ms b.ms)))
  (icollect [i item (ipairs items)] (if (<= i n) item))))

(fn show []
 (let [lines []
       total (or (total) 0)]
  (table.insert lines (string.format "total      %7.1f ms" total))
  (table.insert lines "")
  (table.insert lines :modules)
  (each [_ {: name : ms} (ipairs times)]
   (table.insert lines (string.format "  %-12s %7.2f ms" name ms)))
  (table.insert lines "")
  (table.insert lines :plugins)
  (each [_ {: name : ms} (ipairs (slow-plugins 8))]
   (table.insert lines (string.format "  %-26s %7.2f ms" name ms)))
  (let [width (accumulate [w 34 _ line (ipairs lines)] (math.max w (vim.fn.strdisplaywidth line)))
        height (length lines)
        buf (vim.api.nvim_create_buf false true)]
   (vim.api.nvim_buf_set_lines buf 0 -1 false lines)
   (vim.api.nvim_set_option_value :modifiable false {:buf buf})
   (vim.api.nvim_set_option_value :bufhidden :wipe {:buf buf})
   (local win (vim.api.nvim_open_win buf true
               {:relative :editor
                :style :minimal
                :border :rounded
                :title " startup "
                :title_pos :center
                :width width
                :height height
                :row (math.max 1 (- (math.floor (/ (- vim.o.lines height) 2)) 2))
                :col (math.max 1 (math.floor (/ (- vim.o.columns width) 2)))}))
   (each [_ key (ipairs [:q :<Esc>])]
    (vim.keymap.set :n key #(vim.api.nvim_win_close win true) {:buffer buf})))))

(vim.api.nvim_create_user_command :StartupTime show {:desc "Show the startup time breakdown"})

{: time! : total : summary : show : times : by-name}
