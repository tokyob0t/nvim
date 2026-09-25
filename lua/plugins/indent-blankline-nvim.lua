local Icons = require('icons')

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = Icons.indent,
            -- highlight = {
            --     '@constant.builtin',
            --     '@punctuation.bracket',
            --     'Keyword',
            --     'DiagnosticError',
            --     'Todo',
            --     'String',
            --     'Number',
            -- },
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
