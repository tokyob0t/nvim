(import-macros {: autocmd!} :macros)

(local icons (require :icons))

;; vim.diagnostic is a lazy submodule. Configuring it on the first LspAttach
;; keeps ~2ms off startup, and still runs before any LSP can publish results.
(autocmd! LspAttach *
          `(let [diagnostic vim.diagnostic
                 Severity diagnostic.severity]
            (diagnostic.config {:float {:show_header false :source true}
                                :severity_sort true
                                :signs {:severity {:min Severity.INFO}
                                        :text {Severity.ERROR icons.diagnostics.error
                                               Severity.HINT icons.diagnostics.hint
                                               Severity.INFO icons.diagnostics.info
                                               Severity.WARN icons.diagnostics.warn}}
                                :underline {:severity {:min Severity.INFO}}
                                :update_in_insert false
                                :virtual_lines false
                                :virtual_text {:prefix "#"}}))
          {:once true :desc "Configure diagnostics"})
