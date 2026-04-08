local function button(sc, txt, keybind)
    local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

    local opts = {
        position = 'center',
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = 'right',
        hl = 'AlphaButtons',
    }

    if keybind then
        opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
    end

    return {
        type = 'button',
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, 'normal', false)
        end,
        opts = opts,
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
    val = {
        button('    SPC .', '  Find File  ', ':Telescope find_files<CR>'),
        button('    SPC ,', '󰈭  Find Word  ', ':Telescope live_grep<CR>'),
        button('SPC TAB .', '󰈙  Recent File  ', ':Telescope oldfiles<CR>'),
        button('SPC TAB ,', '  Bookmarks  ', ':Telescope marks<CR>'),
        button('    SPC k', '  Keymaps', ':Telescope keymaps<CR>'),
    },
    opts = {
        spacing = 1,
    },
}

local function get_padding(content_height)
    local win_height = vim.fn.winheight(0)
    return math.max(2, math.floor((win_height - content_height) / 2))
end

local header_height = #default.ascii
local button_count = #default.buttons.val
local button_spacing = default.buttons.opts.spacing or 0

local buttons_height = button_count + (button_count - 1) * button_spacing

local total_height = header_height + 2 + buttons_height

local headerPadding = get_padding(total_height)

return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    main = 'alpha',
    lazy = false,
    -- enabled = false,
    opts = {
        layout = {
            { type = 'padding', val = headerPadding },
            default.header,
            { type = 'padding', val = 2 },
            default.buttons,
        },
        opts = {
            margin = 5,
        },
    },
}
