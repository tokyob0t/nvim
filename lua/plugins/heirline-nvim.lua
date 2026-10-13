local options = vim.opt

local icons = require('icons')

local Navic = require('plugins.heirline-modules.navic')

local VimMode = require('plugins.heirline-modules.vim-mode')
local CurrentFile = require('plugins.heirline-modules.current-file')
local Diagnostics = require('plugins.heirline-modules.diagnostics')
local CursorPosition = require('plugins.heirline-modules.cursor-position')
local LSPStatus = require('plugins.heirline-modules.lsp-status')
local GitBranch = require('plugins.heirline-modules.git-branch')
local CurrentFileType = require('plugins.heirline-modules.current-file-type')

local Buffers = require('plugins.heirline-modules.buffers')
local createAutocmd = require('utils.createAutocmd')

local DEFAULT_EXCLUDED_FILETYPES = {
    'NvimTree.*',
    'Telescope.*',
    -- '[Aa]lpha',
    'dashboard',
}

function table.filter(tbl, fn)
    return vim.tbl_filter(fn, tbl)
end

---@param args { excluded_filetypes?: string[] }
local function WinBar(args)
    if not args.excluded_filetypes then
        args.excluded_filetypes = DEFAULT_EXCLUDED_FILETYPES
    end

    return {
        static = {
            excluded_filetypes = args.excluded_filetypes,
        },
        condition = function(self)
            return not require('heirline.conditions').buffer_matches {
                filetype = self.excluded_filetypes,
            }
        end,
        { unpack(args) },
    }
end

return {
    'rebelot/heirline.nvim',
    dependencies = { 'SmiteshP/nvim-navic' },
    event = 'UiEnter',
    init = function()
        options.showtabline = 0

        vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })

        createAutocmd(
            { 'BufEnter', 'TabEnter', 'BufAdd', 'BufDelete', 'BufModifiedSet', 'BufWritePost' },
            vim.schedule_wrap(function()
                local buffers = vim.api.nvim_list_bufs()

                local count = #table.filter(buffers, function(bufnr)
                    return vim.api.nvim_get_option_value('buflisted', { buf = bufnr })
                end)

                options.showtabline = (count >= 2) and 2 or 0

                vim.cmd.redrawtabline()
            end)
        )
    end,

    opts = {
        tabline = WinBar {
            excluded_filetypes = {},
            Buffers {
                modified_icon = icons.tree.git.unstaged,
                readonly_icon = icons.tree.git.ignored,
            },
        },

        winbar = WinBar {
            { provider = '     ' },
            Navic {},
        },

        statusline = WinBar {
            VimMode {},
            CurrentFile {
                format = ':t',
                enable_file_icon = false,
                modified_icon = icons.tree.git.unstaged,
                readonly_icon = icons.tree.git.ignored,
            },
            GitBranch {
                format = '(λ • #%s)',
            },
            { provider = '%=' }, -- separator
            Diagnostics {
                error_icon = icons.diagnostics.error,
                warn_icon = icons.diagnostics.warn,
                info_icon = icons.diagnostics.info,
                hint_icon = icons.diagnostics.hint,
            },
            CurrentFileType {},
            CursorPosition {},
        },

        opts = {
            disable_winbar_cb = function(args)
                return require('heirline.conditions').buffer_matches({
                    buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
                    filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
                }, args.buf)
            end,
        },
    },
}
