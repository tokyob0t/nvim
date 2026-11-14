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

(local profile (require :modules.profile))

(profile.time! :lazy #(require :modules.lazy))
(profile.time! :settings #(require :modules.settings))
(profile.time! :keymaps #(require :modules.keymaps))
(profile.time! :editor #(require :modules.editor))
