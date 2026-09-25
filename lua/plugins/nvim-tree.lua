local globals = vim.g
local options = vim.opt
local Icons = require('icons')

return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<leader>e', '<cmd>NvimTreeToggle<cr>' },
    },
    opts = {
        view = {
            width = 25,
            side = 'left',
            adaptive_size = true,
        },
        git = { enable = true },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        update_cwd = true,
        hijack_directories = { enable = true, auto_open = true },
        actions = { open_file = { resize_window = true } },
        renderer = {
            root_folder_label = false,
            indent_markers = { enable = false },
            group_empty = true,
            icons = {
                git_placement = 'after',
                symlink_arrow = ' ' .. Icons.common.arrow .. ' ',
                glyphs = Icons.tree,
            },
        },
    },
}
