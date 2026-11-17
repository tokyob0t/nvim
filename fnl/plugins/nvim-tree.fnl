(import-macros {: plugin! : autocmd!} :macros)

(local icons (require :icons))

(plugin! nvim-tree/nvim-tree.lua
 {:dependencies [:nvim-tree/nvim-web-devicons]
  :cmd [:NvimTreeToggle :NvimTreeOpen :NvimTreeFocus :NvimTreeFindFile :NvimTreeCollapse]
  :keys [[:<leader>e :<cmd>NvimTreeToggle<CR>]]
  :init (fn []
         (autocmd! BufEnter * `(when (= :dir (vim.fn.getftype (vim.api.nvim_buf_get_name 0)))
                                (vim.cmd.NvimTreeOpen))))
  :opts {:actions {:open_file {:resize_window true}}
         :disable_netrw true
         :git {:enable true}
         :hijack_cursor true
         :hijack_directories {:auto_open true :enable true}
         :hijack_netrw true
         :renderer {:group_empty true
                    :indent_markers {:enable false}
                    :root_folder_label false
                    :icons {:git_placement :after :glyphs icons.tree :symlink_arrow (.. " " icons.common.arrow " ")}}
         :update_cwd true
         :view {:adaptive_size true :side :left :width 25}}})
