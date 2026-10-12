local icons = require('icons')

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
            [Severity.HINT] = icons.diagnostics.hint,
            [Severity.INFO] = icons.diagnostics.info,
            [Severity.WARN] = icons.diagnostics.warn,
            [Severity.ERROR] = icons.diagnostics.error,
        },
    },
}
