local VIM_MODES = {
    NORMAL = 'RW',
    ['O-PENDING'] = 'RO',
    VISUAL = '**',
    ['V-LINE'] = '**',
    ['V-BLOCK'] = '**',
    s = 'S',
    S = 'SL',
    INSERT = '**',
    ic = '**',
    REPLACE = 'RA',
    ['V-REPLACE'] = 'RV',
    COMMAND = 'VIEX',
    READ = 'r',
    rm = 'r',
    ['r?'] = 'r',
    ['!'] = '!',
    TERMINAL = '',
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-tree.lua',
        'SmiteshP/nvim-navic',
    },
    event = 'VeryLazy',
    init = function()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'TabEnter' }, {
            callback = function()
                local count = #vim.fn.getbufinfo({ buflisted = 1 })

                vim.opt.showtabline = (count >= 2) and 2 or 0
            end,
        })
    end,
    opts = {
        options = {
            icons_enabled = true,
            theme = 'oxocarbon',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            ignore_focus = {},
            always_divide_middle = false,
            globalstatus = true,
            disabled_filetypes = {
                tabline = {
                    'NvimTree',
                    'NvimTree_1',
                    'TelescopePrompt',
                    'Alpha',
                    'alpha',
                    'Telescope',
                    'dashboard',
                },
                winbar = {
                    'NvimTree',
                    'NvimTree_1',
                    'TelescopePrompt',
                    'Alpha',
                    'alpha',
                    'Telescope',
                    'dashboard',
                },
            },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        return VIM_MODES[str] or str
                    end,
                },
            },
            lualine_b = {
                {
                    'filename',
                    file_status = true,
                    newfile_status = true,
                    symbols = {
                        modified = '',
                        readonly = '',
                        unnamed = '',
                    },
                },
                {
                    'branch',
                    fmt = function(str)
                        return str ~= '' and string.format('(λ • #%s)', str)
                    end,
                    icon = '',
                    color = { gui = 'bold,italic' },
                },
            },
            lualine_y = {
                { 'diagnostics', icons_enabled = false },
                { 'filetype', icons_enabled = false },
                { 'location' },
            },
            lualine_c = {},
            lualine_x = {},
            lualine_z = {},
        },
        tabline = {
            lualine_b = {
                {

                    function()
                        local len = vim.api.nvim_win_get_width(
                            require('nvim-tree.view').get_winnr()
                        ) - 1
                        local title = 'Files'
                        local left = (len - #title) / 2
                        local right = len - left - #title

                        return string.rep(' ', left)
                            .. title
                            .. string.rep(' ', right)
                    end,
                    cond = function()
                        return require('nvim-tree.view').is_visible()
                    end,
                },
                {
                    'buffers',
                    icons_enabled = false,
                    show_filename_only = false,
                    hide_filename_extension = false,
                    show_modified_status = true,
                    draw_empty = false,
                    mode = 0,
                    component_separators = { left = '▎', right = '▎' },
                    section_separators = { left = '▎', right = '▎' },
                    symbols = {
                        modified = '',
                        alternate_file = '',
                        directory = '',
                    },
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        packer = 'Packer',
                        fzf = 'FZF',
                        alpha = 'Alpha',
                    },
                    fmt = function(s)
                        return string.format('[%s]', tostring(s))
                    end,
                },
            },
            lualine_a = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        winbar = {
            lualine_b = {
                {
                    'filetype',
                    colored = true,
                    icon_only = false,
                    icon = { align = 'left' },
                    padding = { left = 4, right = 0 },
                    fmt = function(_)
                        local filename = vim.fn.expand('%:t:r')
                        if filename ~= '' then
                            return ' ' .. filename
                        else
                            return ''
                        end
                    end,
                },
                {
                    'separator',
                    padding = { left = 1 },
                    fmt = function(_)
                        local filename = vim.fn.expand('%:t:r')
                        return filename ~= '' and '' or ''
                    end,
                    -- color = 'Comment',
                },
                { 'navic' },
            },
            inactive_winbar = {},
            extensions = {},
        },
    },
}
