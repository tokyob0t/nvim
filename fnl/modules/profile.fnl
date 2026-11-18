;; Startup profiling: per-require wall-clock times gathered by
;; lua/startup-profile, surfaced on the alpha dashboard and :StartupTime.
(import-macros {: autocmd! : command!} :macros)

(local sp (require :utils.startupProfile))

(local records #(sp.records))

;; config modules: the direct children of modules.* (lazy, settings, ...)
(fn modules []
 (icollect [_ {: name : ms} (ipairs (records))]
  (let [module (and (not= name :modules.profile) (name:match "^modules%.([^%.]+)$"))]
   (if module {:name module : ms}))))

;; requires grouped by name and sorted by self time, so parents do not hide
;; their children and repeated requires do not show up twice
(fn requires [n]
 (let [by-name {}]
  (each [_ {: name : self_ms} (ipairs (records))]
   (when (>= self_ms 0.05)
    (tset by-name name (+ self_ms (or (. by-name name) 0)))))
  (let [items (icollect [name ms (pairs by-name)] {: name : ms})]
   (table.sort items (fn [a b] (> a.ms b.ms)))
   (icollect [i item (ipairs items)] (if (<= i n) item)))))

;; freeze the total at VimEnter so :StartupTime keeps reporting startup and
;; not however long the session has been open; stop timing once the UI is up
;; so plugin loads during the session are not recorded
(var total-ms nil)

(autocmd! VimEnter * `(set total-ms (sp.elapsed_ms)) {:desc "freeze the startup total"})
(autocmd! UIEnter * `(sp.uninstall) {:desc "stop timing requires"})

(fn total [] (or total-ms (sp.elapsed_ms)))

(fn counts []
 (let [(ok? lazy) (pcall require :lazy)
       (ok? stats) (if ok? (pcall (fn [] (lazy.stats))) false)]
  {:total (if ok? stats.count 0) :loaded (if ok? stats.loaded 0)}))

(fn cached-count [] (length (sp.cached)))

(fn summary []
 (let [c (counts)]
  (string.format "loaded %d of %d plugins in %.1f ms (%d cached)" c.loaded c.total (or (total) 0) (cached-count))))

(fn loaded-ms [plugin]
 (let [loaded (and (. plugin :_) (. plugin :_ :loaded))]
  (if (and loaded loaded.time) (/ loaded.time 1e6))))

(fn slow-plugins [n]
 (let [(ok? config) (pcall require :lazy.core.config)
       items (if (not ok?) [] (icollect [name plugin (pairs config.plugins)]
                               (let [ms (loaded-ms plugin)]
                                (if ms {: name : ms}))))]
  (table.sort items (fn [a b] (> a.ms b.ms)))
  (icollect [i item (ipairs items)] (if (<= i n) item))))

(fn show []
 (let [lines []
       total (or (total) 0)]
  (table.insert lines (string.format "total      %7.1f ms" total))
  (table.insert lines (string.format "cached     %7d modules" (cached-count)))
  (table.insert lines "")
  (table.insert lines :modules)
  (each [_ {: name : ms} (ipairs (modules))]
   (table.insert lines (string.format "  %-14s %7.2f ms" name ms)))
  (table.insert lines "")
  (table.insert lines :requires)
  (each [_ {: name : ms} (ipairs (requires 12))]
   (table.insert lines (string.format "  %-26s %7.2f ms" name ms)))
  (table.insert lines "")
  (table.insert lines :plugins)
  (each [_ {: name : ms} (ipairs (slow-plugins 8))]
   (table.insert lines (string.format "  %-26s %7.2f ms" name ms)))
  (let [width (accumulate [w 34 _ line (ipairs lines)] (math.max w (vim.fn.strdisplaywidth line)))
        height (length lines)
        buf (vim.api.nvim_create_buf false true)]
   (vim.api.nvim_buf_set_lines buf 0 -1 false lines)
   (vim.api.nvim_set_option_value :modifiable false {: buf})
   (vim.api.nvim_set_option_value :bufhidden :wipe {: buf})
   (local win (vim.api.nvim_open_win buf true
               {:relative :editor
                :style :minimal
                :border :rounded
                :title " startup "
                :title_pos :center
                : width
                : height
                :row (math.max 1 (- (math.floor (/ (- vim.o.lines height) 2)) 2))
                :col (math.max 1 (math.floor (/ (- vim.o.columns width) 2)))}))
   (each [_ key (ipairs [:q :<Esc>])]
    (vim.keymap.set :n key #(vim.api.nvim_win_close win true) {:buffer buf})))))

(command! StartupTime `(show) {:desc "Show the startup time breakdown"})

{: total : summary : show : records : modules : requires}
