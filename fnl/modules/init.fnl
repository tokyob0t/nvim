(import-macros {: let!} :macros)

(let! mapleader " ")

(each [_ plugin (ipairs [:2html_plugin
                         :getscript
                         :getscriptPlugin
                         :gzip
                         :logipat
                         :netrw
                         :netrwPlugin
                         :netrwSettings
                         :netrwFileHandlers
                         :matchit
                         :tar
                         :tarPlugin
                         :rrhelper
                         :spellfile_plugin
                         :vimball
                         :vimballPlugin
                         :zip
                         :zipPlugin
                         :tutor
                         :rplugin
                         :syntax
                         :synmenu
                         :optwin
                         :compiler
                         :bugreport
                         :ftplugin])]
 (set (. vim.g (.. :loaded_ plugin)) 1))

;; loads the profiler early so its VimEnter/UIEnter hooks are registered
;; before the dashboard asks for the numbers
(require :modules.profile)

(require :modules.lazy)
(require :modules.settings)
(require :modules.keymaps)
(require :modules.editor)
