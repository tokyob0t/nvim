local function getKindIconText(ctx)
    local devicons = require('nvim-web-devicons')

    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
        return string.format(' %s%s ', devicons.get_icon(ctx.label), ctx.icon_gap)
    end

    return ctx.kind_icon .. ctx.icon_gap
    -- return KindIcons[ctx.kind] .. ctx.icon_gap
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
    version = '1.*',
    -- build = 'cargo build --release',
    dependencies = {
        'rafamadriz/friendly-snippets',
        -- 'hrsh7th/cmp-cmdline',
        -- 'L3MON4D3/LuaSnip',
        -- 'saadparwaiz1/cmp_luasnip',
        -- 'hrsh7th/cmp-nvim-lsp-signature-help'
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'enter',
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = KindIcons,
            -- highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = 'lua' },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 1500 },
            ghost_text = { enabled = true, show_without_selection = true },
            list = { selection = { preselect = false } },
            menu = {
                draw = {
                    padding = { 0, 1 },
                    columns = { { 'kind_icon' }, { 'label' }, { 'source_name' } },
                    components = {
                        kind_icon = {
                            text = getKindIconText,
                            highlight = getKindIconHighlight,
                        },

                        label = {
                            text = function(ctx)
                                return ctx.label
                            end,
                        },

                        source_name = {
                            text = function(ctx)
                                return '[' .. ctx.source_name .. ']'
                            end,
                        },
                    },
                },
            },
        },

        -- cmdline = {
        --     enabled = true,
        --     keymap = { preset = 'inherit' },
        --     sources = { 'cmdline' },
        --     ghost_text = { enabled = true, show_without_selection = true },
        --     list = { selection = { preselect = false } },
        --     completion = {
        --         menu = { auto_show = true },
        --     },
        -- },

        term = {
            enabled = false,
            keymap = { preset = 'inherit' },
            sources = {},
        },
    },
}
