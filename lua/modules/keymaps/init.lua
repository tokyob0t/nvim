local map = vim.keymap.set

local cmd = vim.cmd
local opt = { noremap = true, silent = true }

-- map('i', '<leader>l', 'λ')

map({ 'n', 'v' }, '<C-Left>', 'b', opt)
map({ 'n', 'v' }, '<C-Right>', 'w', opt)
map({ 'n' }, '<S-Up>', '<Up>', opt)
map({ 'n', 'i' }, '<S-Down>', '<Down>', opt)

--- shift+up/down move higlighted text
map('v', '<S-Up>', ":m '<-2<CR>gv=gv", opt)
map('v', '<S-Down>', ":m '>+1<CR>gv=gv", opt)

--- esc remove search higlights
map('n', '<esc>', '<esc><cmd>noh<cr>', opt)
map('n', '<leader>q', cmd.q, opt)
-- map('n', '<leader>wq', cmd.wq, opt)

map('n', '<leader>i', 'o', opt)
map('n', '<leader>I', 'O', opt)

map('n', '<leader><Tab>[', cmd.bprev, opt)
map('n', '<leader><Tab>]', cmd.bnext, opt)
map('n', '<leader><Tab>d', cmd.bdelete, opt)

map({ 'n', 'v' }, ';', ':', opt)
