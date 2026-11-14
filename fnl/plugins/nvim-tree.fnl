(import-macros {: plugin!} :macros)

(local icons (require :icons))

(local spec (plugin! nvim-tree/nvim-tree.lua
             {:dependencies [:nvim-tree/nvim-web-devicons]
              :cmd [:NvimTreeToggle :NvimTreeOpen :NvimTreeFocus :NvimTreeFindFile :NvimTreeCollapse]
              :keys [[:<leader>e :<cmd>NvimTreeToggle<CR>]]
              :opts {:actions {:open_file {:resize_window true}}
                     :disable_netrw true
                     :git {:enable true}
                     :hijack_cursor true
                     :hijack_directories {:auto_open true :enable true}
                     :hijack_netrw true
                     :renderer {:group_empty true
                                :indent_markers {:enable false}
                                :root_folder_label false
                                :icons {:git_placement :after
                                        :glyphs icons.tree
                                        :symlink_arrow (.. " " icons.common.arrow " ")}}
                     :update_cwd true
                     :view {:adaptive_size true :side :left :width 25}}}))

;; nvim-tree is lazy now, so opening a directory would leave an empty buffer
;; until something loads it. The :NvimTreeOpen stub does the loading.
(vim.api.nvim_create_autocmd :BufEnter {:callback (fn []
                                                   (when (= :dir (vim.fn.getftype (vim.api.nvim_buf_get_name 0)))
                                                    (vim.cmd.NvimTreeOpen)))})

spec
