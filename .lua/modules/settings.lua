-- [nfnl] fnl/modules/settings.fnl
local globals = vim.g
local options = vim.opt
globals.loaded_netrw = 1
globals.loaded_netrwPlugin = 1
options.updatetime = 250
options.timeoutlen = 400
options.swapfile = false
options.conceallevel = 2
options.infercase = true
options.shortmess:append("sWcI")
options.signcolumn = "yes:2"
options.formatoptions = {"q", "j"}
options.termguicolors = true
options.wrap = false
options.cursorline = true
options.statuscolumn = "%C %s%l "
options.splitright = true
options.splitbelow = true
options.expandtab = true
options.tabstop = 4
options.shiftwidth = 4
options.softtabstop = 4
options.clipboard = "unnamedplus"
options.mouse = "a"
options.undofile = true
options.writebackup = false
options.swapfile = false
options.ignorecase = true
options.smartcase = true
options.gdefault = true
options.grepprg = "rg --vimgrep"
options.grepformat = "%f:%l:%c:%m"
options.path = {".", "**"}
options.number = true
options.list = true
options.hidden = true
options.linebreak = true
options.breakindent = true
options.scrolloff = 4
options.fillchars = {diff = "\226\149\177", eob = " ", horiz = " ", msgsep = "\226\148\128", vert = " "}
options.listchars = {extends = "\194\187", nbsp = "\226\144\163", precedes = "\194\171", tab = " \226\148\128\226\148\128", trail = "\194\183"}
return nil
