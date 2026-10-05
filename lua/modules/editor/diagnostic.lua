local Icons = require('icons')

local diagnostic = vim.diagnostic
local Severity = diagnostic.severity

---@diagnostic disable-next-line:param-type-mismatch
diagnostic.config {
    virtual_text = {
        prefix = '#',
    },
    virtual_lines = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        show_header = false,
    },
    underline = {
        severity = {
            min = Severity.INFO,
        },
    },
    signs = {
        severity = {
            min = Severity.INFO,
        },
        text = {
            [Severity.HINT] = Icons.diagnostics.hint,
            [Severity.INFO] = Icons.diagnostics.info,
            [Severity.WARN] = Icons.diagnostics.warn,
            [Severity.ERROR] = Icons.diagnostics.error,
        },
    },
}
