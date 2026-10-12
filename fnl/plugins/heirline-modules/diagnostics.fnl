(fn [args]
  (let [Severity vim.diagnostic.severity]
    {1 {:hl :StatusLineDiagnosticWarn
        :provider (fn [self]
                    (and (> self.warnings 0)
                         (.. self.warn_icon " " self.warnings " ")))}
     2 {:hl :StatusLineDiagnosticError
        :provider (fn [self]
                    (and (> self.errors 0)
                         (.. " " self.error_icon " " self.errors " ")))}
     :condition (fn []
                  ((. (require :heirline.conditions) :has_diagnostics)))
     :init (fn [self]
             (set self.errors
                  (length (vim.diagnostic.get 0 {:severity Severity.ERROR})))
             (set self.warnings
                  (length (vim.diagnostic.get 0 {:severity Severity.WARN})))
             (set self.hints
                  (length (vim.diagnostic.get 0 {:severity Severity.HINT})))
             (set self.info
                  (length (vim.diagnostic.get 0 {:severity Severity.INFO}))))
     :static {:error_icon args.error_icon
              :hint_icon args.hint_icon
              :info_icon args.info_icon
              :warn_icon args.warn_icon}
     :update [:DiagnosticChanged :BufEnter]}))
