return {
    'vyfor/cord.nvim',
    ---@type CordConfig
    opts = {
        text = {
            editing = function(opts)
                local file, line, col = opts.filename, opts.cursor_line, opts.cursor_char

                return string.format('Editing %s - %s:%s', file, line, col)
            end,
        },
        advanced = {
            discord = {
                reconnect = {
                    enabled = true,
                },
            },
        },
    },
}
