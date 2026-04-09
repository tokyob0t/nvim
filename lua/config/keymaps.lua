local keymap = vim.keymap.set

local cmd = vim.cmd
local opt = { noremap = true, silent = true }

-- keymap('i', '<leader>l', 'λ')

keymap({ 'n', 'v' }, '<C-Left>', 'b', opt)
keymap({ 'n', 'v' }, '<C-Right>', 'w', opt)
keymap({ 'n' }, '<S-Up>', '<Up>', opt)
keymap({ 'n', 'i' }, '<S-Down>', '<Down>', opt)

keymap('v', '<S-Up>', ":m '<-2<CR>gv=gv", opt)
keymap('v', '<S-Down>', ":m '>+1<CR>gv=gv", opt)

keymap('n', '<Esc>', ':let @/ = ""<CR>', opt)
keymap('n', '<leader>wq', cmd.wq, opt)
keymap('n', '<leader>q', cmd.q, opt)

keymap('n', '<leader>i', 'o', opt)
keymap('n', '<leader>I', 'O', opt)

keymap('n', '<leader><Tab>[', cmd.bprev, opt)
keymap('n', '<leader><Tab>]', cmd.bnext, opt)
keymap('n', '<leader><Tab>d', cmd.bdelete, opt)

keymap({ 'n', 'v' }, ';', ':', opt)
