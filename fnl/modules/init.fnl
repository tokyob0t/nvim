(import-macros {: let!} :macros)

(let! mapleader " ")
(let! startup-t0 (vim.uv.hrtime))

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

(local {: time!} (require :modules.profile))

(time! :lazy #(require :modules.lazy))
(time! :settings #(require :modules.settings))
(time! :keymaps #(require :modules.keymaps))
(time! :editor #(require :modules.editor))
