return {
    'terrortylor/nvim-comment',
    cmd = { 'CommentToggle' },
    main = 'nvim_comment',
    opts = {
        comment_empty = false,
        create_mappings = false,
    },
    keys = {
        { '<leader>\\', '<cmd>CommentToggle<cr>' },
        { mode = 'v', '<leader>\\', ":'<,'>CommentToggle<cr>" },
    },
}
