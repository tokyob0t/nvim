return {
    'terrortylor/nvim-comment',
    cmd = 'CommentToggle',
    main = 'nvim_comment',
    keys = {
        { '<leader>\\', '<cmd>CommentToggle<CR>' }, -- comment line
        { mode = 'v', '<leader>\\', ":'<,'>CommentToggle<CR>" }, -- comment selection
    },
    opts = {
        comment_empty = false,
        create_mappings = false,
    },
}
