return {
    'terrortylor/nvim-comment',
    cmd = 'CommentToggle',
    main = 'nvim_comment',
    keys = {
        { '<leader>\\', '<cmd>CommentToggle<cr>' }, -- comment line
        { mode = 'v', '<leader>\\', ":'<,'>CommentToggle<cr>" }, -- comment selection
    },
    opts = {
        comment_empty = false,
        create_mappings = false,
    },
}
