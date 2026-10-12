(local variables vim.v)

(fn [...]
  {:init (fn [self]
           (local search (vim.fn.getreg "/"))
           (when (not (and (not= search "") (= variables.hlsearch 1)))
             (set self.search_count nil)
             (lua "return "))
           (local (ok count)
                  (pcall vim.fn.searchcount {:maxcount 999 :timeout 250}))
           (if (and ok (and count (> count.total 0)))
               (set self.search_count
                    (.. "[" count.current "/" count.total "]"))
               (set self.search_count nil)))
   :provider (fn [self]
               (if self.search_count
                   (.. " " self.search_count " ")
                   " %l:%c "))
   :update [:CursorMoved :CursorMovedI :CmdlineLeave :BufEnter]})
