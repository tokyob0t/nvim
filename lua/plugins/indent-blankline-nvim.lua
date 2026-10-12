local icons = require('icons')

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@type ibl.config
    opts = {
        indent = {
            char = icons.indent,
        },
        scope = {
            highlight = {
                '@constant.builtin',
                '@punctuation.bracket',
                'Keyword',
                'DiagnosticError',
                'Todo',
                'String',
                'Number',
            },
            exclude = {
                language = {
                    'fennel',
                    'clojure',
                    'lisp',
                    'racket',
                    'scheme',
                },
            },
        },
    },
}
