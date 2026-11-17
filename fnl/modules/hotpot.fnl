(import-macros {: autocmd! : command!} :macros)
(local install-plugin (require :utils.installPlugin))

;; hotpot is lazy: the compiler only loads when something has to be compiled

(fn sync! []
 (install-plugin :hotpot :rktjmp/hotpot.nvim :main)
 (let [api (require :hotpot.api)
       ctx (assert (api.context (vim.fn.stdpath :config)))]
  (ctx.sync)))

(fn sync-on-save! []
 (when (not package.loaded.hotpot)
  (let [(ok? err) (pcall sync!)]
   (when (not ok?)
    (vim.notify (.. "hotpot sync failed: " (tostring err)) vim.log.levels.ERROR)))))

(autocmd! BufWritePost [*.fnl *.fnlm] `(sync-on-save!) {:desc "Compile fennel into the hotpot cache"})

(command! HotpotSync `(sync!) {:desc "Recompile fnl/ into the hotpot cache"})
