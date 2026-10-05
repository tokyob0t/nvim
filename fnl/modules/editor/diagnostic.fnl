(local Icons (require :icons))
(local diagnostic vim.diagnostic)
(local Severity diagnostic.severity)
(diagnostic.config {:float {:show_header false :source true}
                    :severity_sort true
                    :signs {:severity {:min Severity.INFO}
                            :text {Severity.ERROR Icons.diagnostics.error
                                   Severity.HINT Icons.diagnostics.hint
                                   Severity.INFO Icons.diagnostics.info
                                   Severity.WARN Icons.diagnostics.warn}}
                    :underline {:severity {:min Severity.INFO}}
                    :update_in_insert false
                    :virtual_lines false
                    :virtual_text {:prefix "#"}})
