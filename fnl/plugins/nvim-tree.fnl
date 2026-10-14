(local icons (require :icons))

{1 :nvim-tree/nvim-tree.lua
 :lazy false
 :dependencies [:nvim-tree/nvim-web-devicons]
 :keys [[:<leader>e :<cmd>NvimTreeToggle<CR>]]
 :opts {:actions {:open_file {:resize_window true}}
        :disable_netrw true
        :git {:enable true}
        :hijack_cursor true
        :hijack_directories {:auto_open true :enable true}
        :hijack_netrw true
        :renderer {:group_empty true
                   :icons {:git_placement :after
                           :glyphs icons.tree
                           :symlink_arrow (.. " " icons.common.arrow " ")}
                   :indent_markers {:enable false}
                   :root_folder_label false}
        :update_cwd true
        :view {:adaptive_size true :side :left :width 25}}}
