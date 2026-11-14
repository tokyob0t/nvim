;; The FileType hook lives here, not in the nvim-treesitter spec, because it
;; has to exist even when the plugin has not loaded yet. Otherwise buffers
;; whose filetype is set outside of :e (fff previews, scratch buffers, ...)
;; stay unlit until some file is opened.
(import-macros {: autocmd!} :macros)

(autocmd! FileType * `(do
                       (pcall vim.treesitter.start)
                       nil))
