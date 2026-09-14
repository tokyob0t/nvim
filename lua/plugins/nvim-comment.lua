return {
    'terrortylor/nvim-comment',
    cmd = 'CommentToggle',
    main = 'nvim_comment',
    opts = {
        comment_empty = false,
        create_mappings = false,
    },
    keys = {
        -- comment line
        { '<leader>\\', '<cmd>CommentToggle<cr>' },
        -- comment selection
        { mode = 'v', '<leader>\\', ":'<,'>CommentToggle<cr>" },
    },
}
