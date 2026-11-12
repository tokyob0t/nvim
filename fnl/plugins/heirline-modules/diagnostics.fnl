(local Severity vim.diagnostic.severity)

(fn [{: error-icon : hint-icon : info-icon : warn-icon}]
  (let [get-severity #(length (vim.diagnostic.get 0 {:severity $}))]
    {:init (fn [self]
             (set self.errors (get-severity Severity.ERROR))
             (set self.warnings (get-severity Severity.WARN)))
     :update [:DiagnosticChanged :BufEnter]
     :condition #(let [{: has_diagnostics} (require :heirline.conditions)]
                   (has_diagnostics))
     :static {: error-icon : hint-icon : info-icon : warn-icon}
     1 [{:hl :StatusLineDiagnosticWarn
         :provider (fn [{: warnings : warn-icon}]
                     (if (> warnings 0)
                         (string.format "%s %s " warn-icon warnings)))}
        {:hl :StatusLineDiagnosticError
         :provider (fn [{: errors : error-icon}]
                     (if (> errors 0)
                         (string.format "%s %s " error-icon errors)))}]}))
