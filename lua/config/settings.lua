local globals = vim.g
local cmd = vim.cmd
local options = vim.opt
local diagnostic = vim.diagnostic
local set = cmd.set

diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
})

globals.loaded_netrw = 1
-- options.showtabline = 0
options.conceallevel = 2
options.undofile = true
options.cursorline = true
options.number = true
options.termguicolors = true
options.clipboard = 'unnamedplus'
-- options.clipboard = { "unnamed", "unnamedplus" }
options.fillchars = {
    eob = ' ',
    vert = ' ',
    horiz = ' ',
    diff = '╱',
    foldclose = '',
    foldopen = '',
    fold = ' ',
    msgsep = '─',
}

options.listchars = {
    tab = ' ──',
    trail = '·',
    nbsp = '␣',
    precedes = '«',
    extends = '»',
}

options.tabstop = 4
options.shiftwidth = 4
options.softtabstop = 4
options.scrolloff = 4
-- options.grepprg = 'rg --vimgrep'
options.grepformat = '%f:%l:%c:%m'
options.signcolumn = 'yes:1'
options.updatetime = 250
options.timeoutlen = 400
options.foldcolumn = '1'
options.foldlevel = 99
options.foldlevelstart = 99
options.foldenable = true

set('expandtab')
set('infercase')
set('ignorecase')
set('smartcase')
set('gdefault')
set('nowrap')
set('number')
set('list')
set('hidden')
set('linebreak')
set('breakindent')

KindIcons = {
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
    Namespace = '  ',
    Package = '  ',
    String = '  ',
    Text = '  ',
    Number = '  ',
    Array = '  ',
    Object = '  ',
    Key = '  ',
    Boolean = '  ',
    Null = '  ',
    ---
    -- enabled = true,
}

vim.diagnostic.config({
    virtual_text = { prefix = '#' },
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = '󰌶',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.ERROR] = '',
            --[vim.diagnostic.severity.OTHER] = '',
        },
    },
})
