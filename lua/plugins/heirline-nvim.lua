local options = vim.opt

local Icons = require('icons')

local Navic = require('plugins.heirline-modules.navic')

local VimMode = require('plugins.heirline-modules.vim-mode')
local CurrentFile = require('plugins.heirline-modules.current-file')
local Diagnostics = require('plugins.heirline-modules.diagnostics')
local CursorPosition = require('plugins.heirline-modules.cursor-position')
local LSPStatus = require('plugins.heirline-modules.lsp-status')
local GitBranch = require('plugins.heirline-modules.git-branch')
local CurrentFileType = require('plugins.heirline-modules.current-file-type')

local Buffers = require('plugins.heirline-modules.buffers')

local DEFAULT_EXCLUDED_FILETYPES = {
    'NvimTree.*',
    'Telescope.*',
    -- '[Aa]lpha',
    'dashboard',
}

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

        vim.api.nvim_create_autocmd(
            { 'BufEnter', 'TabEnter', 'BufAdd', 'BufDelete', 'BufModifiedSet', 'BufWritePost' },
            {
                callback = vim.schedule_wrap(function()
                    local count = #vim.tbl_filter(function(bufnr)
                        return vim.api.nvim_get_option_value('buflisted', { buf = bufnr })
                    end, vim.api.nvim_list_bufs())

                    -- local count = #vim.fn.getbufinfo { buflisted = 1 }
                    options.showtabline = (count >= 2) and 2 or 0
                    vim.cmd.redrawtabline()
                end),
            }
        )
    end,

    opts = {
        tabline = WinBar {
            excluded_filetypes = {},
            Buffers {},
        },

        winbar = WinBar {
            { provider = '     ' },
            Navic {},
        },

        statusline = WinBar {
            VimMode {},
            CurrentFile {
                file_icon = false,
                editable_icon = true,
            },
            GitBranch {
                format = '(λ • #%s)',
            },
            { provider = '%=' }, -- separator
            Diagnostics {
                error_icon = Icons.diagnostics.error,
                warn_icon = Icons.diagnostics.warn,
                info_icon = Icons.diagnostics.info,
                hint_icon = Icons.diagnostics.hint,
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
