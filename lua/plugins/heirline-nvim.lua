local Navic = require('plugins.heirline-modules.navic')

local VimMode = require('plugins.heirline-modules.vim-mode')
local CurrentFile = require('plugins.heirline-modules.current-file')
local Diagnostics = require('plugins.heirline-modules.diagnostics')
local CursorPosition = require('plugins.heirline-modules.cursor-position')
local LSPStatus = require('plugins.heirline-modules.lsp-status')
local GitBranch = require('plugins.heirline-modules.git-branch')
local CurrentFileType = require('plugins.heirline-modules.current-file-type')

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
    dependencies = {
        'SmiteshP/nvim-navic',
    },
    event = 'UiEnter',
    opts = {
        winbar = WinBar {
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
            { provider = '%=' },
            Diagnostics {},
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
