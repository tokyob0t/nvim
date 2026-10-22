local icons = require('icons')
local options = vim.opt

return {
    'saghen/blink.cmp',
    -- build = 'cargo build --release',
    dependencies = {
        'saghen/blink.lib',
        'rafamadriz/friendly-snippets',
        'nvim-tree/nvim-web-devicons',
    },

    init = function()
        options.completeopt = { 'menu', 'menuone', 'noselect' }
    end,

    opts_extend = { 'sources.default' },

    opts = {
        keymap = {
            preset = 'enter',
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = icons.kinds,
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = 'lua' },

        completion = {
            documentation = { auto_show = true },
            ghost_text = { enabled = true, show_without_selection = true },
            list = { selection = { preselect = false } },
            menu = {
                draw = {
                    padding = { 0, 1 },
                    columns = { { 'kind_icon' }, { gap = 1, width = 30, 'label', 'source_name' } },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return string.format('%s%s', ctx.kind_icon, ctx.icon_gap)
                            end,
                            highlight = function(ctx)
                                return ctx.kind_hl
                            end,
                        },

                        label = {
                            width = { fill = true, max = 30 },
                            text = function(ctx)
                                return ctx.label
                            end,
                        },

                        source_name = {
                            width = { max = 20 },
                            text = function(ctx)
                                return '[' .. ctx.source_name .. ']'
                            end,
                        },
                    },
                },
            },
        },

        cmdline = {
            enabled = true,
            keymap = { preset = 'inherit' },
            sources = { default = { 'cmdline', 'buffer' } },
            completion = {
                list = { selection = { preselect = false } },
                menu = { auto_show = true },
                ghost_text = { enabled = true, show_without_selection = true },
                documentation = { auto_show = true },
            },
        },

        term = {
            enabled = false,
            keymap = { preset = 'inherit' },
            sources = {},
        },
    },
}
