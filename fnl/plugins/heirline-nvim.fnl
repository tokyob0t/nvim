(local options vim.opt)
(local create-autocmd vim.api.nvim_create_autocmd)
(local get-option-value vim.api.nvim_get_option_value)

(local icons (require :icons))
(local Navic (require :plugins.heirline-modules.navic))
(local VimMode (require :plugins.heirline-modules.vim-mode))
(local CurrentFile (require :plugins.heirline-modules.current-file))
(local Diagnostics (require :plugins.heirline-modules.diagnostics))
(local CursorPosition (require :plugins.heirline-modules.cursor-position))
(local LSPStatus (require :plugins.heirline-modules.lsp-status))
(local GitBranch (require :plugins.heirline-modules.git-branch))
(local CurrentFileType (require :plugins.heirline-modules.current-file-type))
(local Buffers (require :plugins.heirline-modules.buffers))

(local DEFAULT_EXCLUDED_FILETYPES [:NvimTree.* :Telescope.* :dashboard])

(fn WinBar [{: excluded_filetypes &as args}]
  {1 [(unpack args)]
   :static {:excluded_filetypes (or excluded_filetypes
                                    DEFAULT_EXCLUDED_FILETYPES)}
   :condition #(let [{: excluded_filetypes} $
                     conditions (require :heirline.conditions)]
                 (not (conditions:buffer_matches {:filetype excluded_filetypes})))})

{1 :rebelot/heirline.nvim
 :dependencies [:SmiteshP/nvim-navic]
 :event :UiEnter
 :init #(let [EVENTS [:BufEnter
                      :TabEnter
                      :BufAdd
                      :BufDelete
                      :BufModifiedSet
                      :BufWritePost]]
          (set options.showtabline 0)
          (vim.api.nvim_set_hl 0 :WinBar {:bg :NONE})
          (create-autocmd EVENTS
                          {:callback (vim.schedule_wrap #(let [count (length (vim.tbl_filter (fn [bufnr]
                                                                                               (get-option-value :buflisted
                                                                                                                 {:buf bufnr}))
                                                                                             (vim.api.nvim_list_bufs)))]
                                                           (set options.showtabline
                                                                (or (and (>= count
                                                                             2)
                                                                         2)
                                                                    0))
                                                           (vim.cmd.redrawtabline)))}))
 :opts {:opts {:disable_winbar_cb #(let [{: buf} $
                                         conditions (require :heirline.conditions)]
                                     (conditions:buffer_matches {:buftype [:nofile
                                                                           :prompt
                                                                           :help
                                                                           :quickfix]
                                                                 :filetype [:^git.*
                                                                            :fugitive
                                                                            :Trouble
                                                                            :dashboard]}
                                                                buf))}
        :statusline (WinBar {1 (VimMode {})
                             2 (CurrentFile {:enable_file_icon false
                                             :format ":t"
                                             :modified_icon icons.tree.git.unstaged
                                             :readonly_icon icons.tree.git.ignored})
                             3 (GitBranch {:format "(λ • #%s)"})
                             4 {:provider "%="}
                             5 (Diagnostics {:error_icon icons.diagnostics.error
                                             :hint_icon icons.diagnostics.hint
                                             :info_icon icons.diagnostics.info
                                             :warn_icon icons.diagnostics.warn})
                             6 (CurrentFileType {})
                             7 (CursorPosition {})})
        :tabline (WinBar {1 (Buffers {:modified_icon icons.tree.git.unstaged
                                      :readonly_icon icons.tree.git.ignored})
                          :excluded_filetypes {}})
        :winbar (WinBar {1 (Navic {})})}}
