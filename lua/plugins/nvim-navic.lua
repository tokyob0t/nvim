return {
    'SmiteshP/nvim-navic',
    dependencies = { 'nyoom-engineering/oxocarbon.nvim' },
    lazy = false,
    init = function()
        local oxocarbon = require('oxocarbon').oxocarbon

        local set = function(name, color)
            vim.api.nvim_set_hl(0, name, { default = true, fg = color })
        end

        set('NavicSeparator', oxocarbon.base03)
        set('NavicIconsFile', oxocarbon.base14)

        set('NavicIconsModule', oxocarbon.base11)
        set('NavicIconsNamespace', oxocarbon.base11)
        set('NavicIconsPackage', oxocarbon.base11)

        set('NavicIconsClass', oxocarbon.base11)
        set('NavicIconsInterface', oxocarbon.base08)
        set('NavicIconsStruct', oxocarbon.base11)

        set('NavicIconsMethod', oxocarbon.base15)
        set('NavicIconsFunction', oxocarbon.base11)
        set('NavicIconsConstructor', oxocarbon.base10)

        set('NavicIconsVariable', oxocarbon.base14)
        set('NavicIconsField', oxocarbon.base12)
        set('NavicIconsProperty', oxocarbon.base12)

        set('NavicIconsEnum', oxocarbon.base09)
        set('NavicIconsEnumMember', oxocarbon.base15)

        set('NavicIconsConstant', oxocarbon.base10)
        set('NavicIconsString', oxocarbon.base09)
        set('NavicIconsNumber', oxocarbon.base15)
        set('NavicIconsBoolean', oxocarbon.base15)
        set('NavicIconsNull', oxocarbon.base15)
        set('NavicIconsKey', oxocarbon.base09)

        set('NavicIconsArray', oxocarbon.base11)
        set('NavicIconsObject', oxocarbon.base11)

        set('NavicIconsEvent', oxocarbon.base12)
        set('NavicIconsOperator', oxocarbon.base11)
        set('NavicIconsTypeParameter', oxocarbon.base08)
        vim.api.nvim_set_hl(0, 'WinBar', { bg = oxocarbon.base00 })
        -- vim.api.nvim_set_hl(0, 'WinBarNC', { fg = '#aaaaaa', bg = '#1e1e1e' })
    end,
    opts = {
        lsp = { auto_attach = true },
        icons = KindIcons,
        separator = '  ',
        highlight = true,
    },
}
