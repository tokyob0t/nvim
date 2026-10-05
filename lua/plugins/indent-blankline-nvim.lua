local Icons = require('icons')

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@type ibl.config
    opts = {
        indent = {
            char = Icons.indent,
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
