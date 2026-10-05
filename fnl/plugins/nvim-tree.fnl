{[1] :nvim-tree/nvim-tree.lua
 :cmd [:NvimTreeToggle :NvimTreeFocus :NvimTreeFindFile :NvimTreeCollapse]
 :keys [{1 :<leader>e 2 :<cmd>NvimTreeToggle<CR> :desc "Toggle NvimTree"}]
 :opts {:on_attach (fn [bufnr]
                     (local api (require :nvim-tree.api))
                     (local function opts [desc]
                       {:desc (.. "nvim-tree: " desc)
                        :buffer bufnr
                        :noremap true
                        :silent true
                        :nowait true})
                     (api.config.mappings.default_on_attach bufnr)
                     (vim.keymap.set :n :l (fn [] (api.node.open.edit)) (opts :Open))
                     (vim.keymap.set :n :h (fn [] (api.node.navigate.parent_close)) (opts :Close Dir))
                     (vim.keymap.set :n :v (fn [] (api.node.open.vertical)) (opts :Open:Vertical Split)))
        :filters {:dotfiles true
                  :custom [:__pycache__]}
        :view {:adaptive_size true
               :side :left}
        :renderer {:icons {:glyphs {:folder {:arrow_open ""
                                             :arrow_closed ""
                                             :default ""
                                             :open ""
                                             :empty ""
                                             :empty_open ""
                                             :symlink ""
                                             :symlink_open ""}
                                    :git {:unstaged "✗"
                                          :staged "✓"
                                          :unmerged ""
                                          :renamed "➜"
                                          :untracked "★"
                                          :deleted ""
                                          :ignored "◌"}}}}
        :git {:enable true
              :ignore false}}}
