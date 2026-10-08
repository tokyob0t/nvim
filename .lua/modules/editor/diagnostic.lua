-- [nfnl] fnl/modules/editor/diagnostic.fnl
local Icons = require("icons")
local diagnostic = vim.diagnostic
local Severity = diagnostic.severity
return diagnostic.config({float = {source = true, show_header = false}, severity_sort = true, signs = {severity = {min = Severity.INFO}, text = {[Severity.ERROR] = Icons.diagnostics.error, [Severity.HINT] = Icons.diagnostics.hint, [Severity.INFO] = Icons.diagnostics.info, [Severity.WARN] = Icons.diagnostics.warn}}, underline = {severity = {min = Severity.INFO}}, virtual_text = {prefix = "#"}, update_in_insert = false, virtual_lines = false})
