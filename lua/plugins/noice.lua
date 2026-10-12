local icons = require('icons')

return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    opts = {
        presets = { long_message_to_split = true, lsp_doc_border = true },
        health = { checker = false },
        popupmenu = { backend = 'cmp' },
        format = {},
        cmdline = {
            format = {
                cmdline = { pattern = '^:', icon = icons.common.terminal .. ' ', lang = 'vim' },
                search_down = {
                    kind = 'search',
                    pattern = '^/',
                    icon = icons.common.search .. ' ',
                    lang = 'regex',
                },
                search_up = {
                    kind = 'search',
                    pattern = '^%?',
                    icon = icons.common.search .. ' ',
                    lang = 'regex',
                },
                replace = { pattern = '^:%%s%/', icon = icons.common.regex, lang = 'regex' },
                filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
                lua = { pattern = '^:%s*lua%s+', icon = icons.common.lua, lang = 'lua' },
                help = { pattern = '^:%s*help%s+', icon = icons.common.help },
                input = { icon = icons.common.input .. ' ' },
            },
            opts = {
                win_options = {
                    winhighlight = {
                        Normal = 'NormalFloat',
                        FloatBorder = 'FloatBorder',
                    },
                },
            },
        },
        lsp = {
            progress = {
                enabled = true,
            },
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        views = {
            cmdline_popup = {
                position = { row = 0, col = '50%' },
                size = { width = '98%' },
            },
        },
        -- routes = {
        --     {
        --         filter = {
        --             event = 'cmdline',
        --             kind = 'input',
        --         },
        --         view = 'cmdline_popup',
        --     },
        -- },
    },
}
