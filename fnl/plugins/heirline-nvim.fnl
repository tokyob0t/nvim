(import-macros {: set! : autocmd! : custom-set-face!} :macros)

(local create-autocmd (require :utils.createAutocmd))

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

(local EXCLUDED_FILETYPES [:NvimTree.*
                           :Telescope.*
                           :dashboard
                           :^git.*
                           :fugitive
                           :Trouble
                           :dashboard])

(local EXCLUDED_BUFTYPES [:nofile :prompt :help :quickfix])

(fn WinBar [?excluded-filetypes childrens]
  {1 childrens
   :static {:excluded_filetypes (or ?excluded-filetypes EXCLUDED_FILETYPES)}
   :condition (fn [{: excluded_filetypes}]
                (let [{: buffer_matches} (require :heirline.conditions)]
                  (not (buffer_matches {:filetype excluded_filetypes}))))})

{1 :rebelot/heirline.nvim
 :dependencies [:SmiteshP/nvim-navic]
 :event :UiEnter
 :init #(let [EVENTS [:BufEnter
                      :TabEnter
                      :BufAdd
                      :BufDelete
                      :BufModifiedSet
                      :BufWritePost]
              {: nvim_get_option_value} vim.api
              list-buffers #(collect [_ bufnr (ipairs (vim.api.nvim_list_bufs))]
                              (if (nvim_get_option_value :buflisted
                                                         {:buf bufnr})
                                  bufnr))]
          (set! showtabline 0)
          (custom-set-face! :WinBar [] {:bg :NONE})
          (create-autocmd EVENTS
                          (let [_ vim.schedule_wrap]
                            #(let [count (list-buffers)]
                               (set! showtabline (or (and (>= count 2) 2) 0))
                               (vim.cmd.redrawtabline)))))
 :opts {:statusline (WinBar []
                            [(VimMode {})
                             (CurrentFile {:enable_file_icon false
                                           :format ":t"
                                           :modified_icon icons.tree.git.unstaged
                                           :readonly_icon icons.tree.git.ignored})
                             (GitBranch {:format "(λ • #%s)"})
                             {:provider "%="}
                             (Diagnostics {:error_icon icons.diagnostics.error
                                           :hint_icon icons.diagnostics.hint
                                           :info_icon icons.diagnostics.info
                                           :warn_icon icons.diagnostics.warn})
                             (CurrentFileType {})
                             (CursorPosition {})])
        :_tabline (WinBar []
                          [(Buffers {:modified_icon icons.tree.git.unstaged
                                     :readonly_icon icons.tree.git.ignored})])
        :_winbar (WinBar [] [(Navic {})])
        :opts {:disable_winbar_cb (fn [{: buf}]
                                    (let [{: buffer_matches} (require :heirline.conditions)]
                                      (buffer_matches {:buftype EXCLUDED_BUFTYPES
                                                       :filetype EXCLUDED_FILETYPES}
                                                      buf)))}}}
