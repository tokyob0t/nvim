(local icons (require :icons))
(local diagnostic vim.diagnostic)
(local Severity diagnostic.severity)

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
                    :virtual_text {:prefix "#"}})
