local icons = require('icons')

return {
    'SmiteshP/nvim-navic',
    lazy = false,
    opts = {
        lsp = { auto_attach = true },
        highlight = true,
        icons = icons.kinds,
        separator = ' ' .. icons.common.chevron_right .. ' ',
    },
}
