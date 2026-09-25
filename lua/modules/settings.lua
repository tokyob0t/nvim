local globals = vim.g
local options = vim.opt

--  speedup
globals.loaded_netrw = 1
globals.loaded_netrwPlugin = 1
options.updatetime = 250
options.timeoutlen = 400

--  visual options
options.swapfile = false
options.conceallevel = 2
options.infercase = true
options.shortmess:append('sWcI')
options.signcolumn = 'yes:2'
options.formatoptions = { 'q', 'j' }
options.termguicolors = true
options.wrap = false
options.cursorline = true
options.statuscolumn = '%C %s%l '

-- just good defaults
options.splitright = true
options.splitbelow = true

-- tab options
options.expandtab = true
options.tabstop = 4
options.shiftwidth = 4
options.softtabstop = 4

-- clipboard and mouse
options.clipboard = 'unnamedplus'
options.mouse = 'a'

-- backups are annoying
options.undofile = true
options.writebackup = false
options.swapfile = false

-- search and replace
options.ignorecase = true
options.smartcase = true
options.gdefault = true

-- better grep
options.grepprg = 'rg --vimgrep'
options.grepformat = '%f:%l:%c:%m'
options.path = { '.', '**' }

-- gui options
options.number = true
options.list = true
options.hidden = true
options.linebreak = true
options.breakindent = true
options.scrolloff = 4

options.fillchars = {
    eob = ' ',
    vert = ' ',
    horiz = ' ',
    diff = '╱',
    msgsep = '─',
}

options.listchars = {
    tab = ' ──',
    trail = '·',
    nbsp = '␣',
    precedes = '«',
    extends = '»',
}
