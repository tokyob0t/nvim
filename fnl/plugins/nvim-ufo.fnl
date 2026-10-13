{1 :kevinhwang91/nvim-ufo
 :dependencies [:kevinhwang91/promise-async]
 :event :BufReadPost
 :keys [[:fc :<cmd>foldclose<cr>]
        [:ff :<cmd>foldopen<cr>]
        {1 :fc 2 ":'<,'>foldclose<cr>" :mode :v}
        {1 :ff 2 ":'<,'>foldopen<cr>" :mode :v}]
 :opts {:provider_selector (fn [_bufnr _filetype _buftype]
                             [:treesitter :indent])}}
