local Icons = require('icons')

return {
    'SmiteshP/nvim-navic',
    lazy = false,
    opts = {
        lsp = { auto_attach = true },
        highlight = true,
        icons = Icons.kinds,
        separator = ' ' .. Icons.common.chevron_right .. ' ',
    },
}
