local Icons = require('icons')
local options = vim.opt

local function getKindIconText(ctx)
    local devicons = require('nvim-web-devicons')

    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
        return ' ' .. devicons.get_icon(ctx.label) .. ctx.icon_gap .. ' '
    end

    return ctx.kind_icon .. ctx.icon_gap
end

local function getKindIconHighlight(ctx)
    local devicons = require('nvim-web-devicons')
    local hl = ctx.kind_hl

    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
        local dev_icon, dev_hl = devicons.get_icon(ctx.label)
        if dev_icon then
            hl = dev_hl
        end
    end

    return hl
end

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
    opts = {
        keymap = {
            preset = 'enter',
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = Icons.kinds,
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
                            text = getKindIconText,
                            highlight = getKindIconHighlight,
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
