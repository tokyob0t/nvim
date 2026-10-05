{[1] :kevinhwang91/nvim-ufo
 :dependencies [{[1] :kevinhwang91/promise-async}]
 :event :VeryLazy
 :opts {:provider_selector (fn [_ _ _] [:treesitter :indent])
        :fold_virt_text_handler (fn [virtText lnum endLnum width truncate]
                                  (let [newVirtText []
                                        suffix (: "  %d " :format (- endLnum lnum))]
                                    (var curWidth 0)
                                    (each [i chunk (ipairs virtText)]
                                      (let [chunkText (. chunk 1)
                                            chunkWidth (vim.fn.strdisplaywidth chunkText)]
                                        (if (> (+ curWidth chunkWidth) width)
                                            (do
                                              (table.insert newVirtText {1 (truncate chunkText (- width curWidth suffix)) 2 (. chunk 2)})
                                              (set curWidth (+ curWidth (vim.fn.strdisplaywidth (. newVirtText (length newVirtText)) 1))))
                                            (do
                                              (table.insert newVirtText chunk)
                                              (set curWidth (+ curWidth chunkWidth))))))
                                    (table.insert newVirtText {1 suffix 2 :MoreMsg})
                                    newVirtText))}}
