return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        view = {
            side = 'left',
            width = 25,
            adaptive_size = true,
        },
        renderer = {
            root_folder_label = false,
            indent_markers = { enable = false },
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        update_cwd = true,
        git = { enable = false },
        hijack_directories = { enable = true, auto_open = true },
        actions = { open_file = { resize_window = true } },
    },
    keys = {
        { '<leader>e', '<cmd>NvimTreeToggle<cr>' },
    },
}
