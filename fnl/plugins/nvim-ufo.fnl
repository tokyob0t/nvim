{1 :kevinhwang91/nvim-ufo
 :dependencies [:kevinhwang91/promise-async]
 :event :BufReadPost
 :keys [[:fc :<cmd>foldclose<CR>]
        [:ff :<cmd>foldopen<CR>]
        {1 :fc 2 ":'<,'>foldclose<CR>" :mode :v}
        {1 :ff 2 ":'<,'>foldopen<CR>" :mode :v}]
 :opts {:provider_selector (fn [_bufnr _filetype _buftype]
                             [:treesitter :indent])}}
