local diagnostic = vim.diagnostic
local Severity = diagnostic.severity

diagnostic.config {
    virtual_text = { prefix = '#' },
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
            [Severity.HINT] = '󰌶',
            [Severity.INFO] = '',
            [Severity.WARN] = '',
            [Severity.ERROR] = '',
        },
    },
}
