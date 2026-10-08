(local default (let [cfg (require :nfnl.config)]
                 (cfg.default)))

{:verbose false
 :header-comment true
 :header-search-lines 5
 :source-file-patterns [:fnl/**/*.fnl]
 :orphan-detection {:auto? true}
 :fnl-path->lua-path (fn [fnl-path]
                       (let [rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
                         (.. "." (default.fnl-path->lua-path rel-fnl-path))))}
