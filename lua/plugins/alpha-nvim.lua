local icons = require('icons')

local function button(txt, sc, keybind)
    local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

    return {
        type = 'button',
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)

            vim.api.nvim_feedkeys(key, 'normal', false)
        end,
        opts = {
            position = 'center',
            text = txt,
            shortcut = sc,
            cursor = 5,
            width = 36,
            align_shortcut = 'right',
            hl = 'AlphaButtons',
            keymap = keybind and { 'n', sc_, keybind, { noremap = true, silent = true } },
        },
    }
end

local default = {}

default.ascii = {
    '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
    '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
    '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
    '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
}

default.header = {
    type = 'text',
    val = default.ascii,
    opts = {
        position = 'center',
        hl = 'Comment',
    },
}

default.buttons = {
    type = 'group',
    opts = { spacing = 1 },
    val = {
        button(icons.common.search .. '  Find Files ', '    SPC .', '<cmd>FFFindFiles<CR>'),
        button(icons.common.word .. '  Find Word  ', '    SPC ,', '<cmd>FFFuzzySearch<CR>'),
        button(icons.common.lua .. '  Lazy', 'SPC l', '<cmd>Lazy<CR>'),
        button(icons.common.plugin .. '  Mason  ', 'SPC m', '<cmd>Mason<CR>'),
    },
}

local function getPadding(content_height)
    return math.max(2, math.floor((vim.fn.winheight(0) - content_height) / 2))
end

local header_height = #default.ascii
local button_count = #default.buttons.val
local button_spacing = default.buttons.opts.spacing or 0

local buttons_height = button_count + (button_count - 1) * button_spacing

local total_height = header_height + 2 + buttons_height

local header_padding = getPadding(total_height)

return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = 'VimEnter',
    opts = {
        opts = {
            margin = 5,
        },
        layout = {
            { type = 'padding', val = header_padding },
            default.header,
            { type = 'padding', val = 2 },
            default.buttons,
        },
    },
}
