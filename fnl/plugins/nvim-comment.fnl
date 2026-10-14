{1 :terrortylor/nvim-comment
 :cmd :CommentToggle
 :keys [["<leader>\\" :<cmd>CommentToggle<CR>]
        {1 "<leader>\\" 2 ":'<,'>CommentToggle<CR>" :mode :v}]
 :main :nvim_comment
 :opts {:comment_empty false :create_mappings false}}
