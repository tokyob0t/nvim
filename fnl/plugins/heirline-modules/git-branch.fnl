(fn [args]
  (when (not args.format) (set args.format " #%s "))
  {:condition (fn []
                ((. (require :heirline.conditions) :is_git_repo)))
   :hl {:bold true}
   :init (fn [self]
           (set self.status_dict vim.b.gitsigns_status_dict)
           (set self.has_changes
                (or (or (not= self.status_dict.added 0)
                        (not= self.status_dict.removed 0))
                    (not= self.status_dict.changed 0))))
   :provider (fn [self] (string.format args.format self.status_dict.head))
   :update {1 :BufEnter 2 :User :pattern [:GitSignsUpdate :GitSignsChanged]}})
