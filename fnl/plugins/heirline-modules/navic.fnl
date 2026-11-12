(local CurrentFile (require :plugins.heirline-modules.current-file))
(local icons (require :icons))

(fn []
  [(CurrentFile {:format ":t:r" :enable-file-icon true})
   {:provider (.. icons.common.chevron_right " ")
    :update "CursorMoved"
    :hl "NavicSeparator"
    :condition #(let [navic (require :nvim-navic)
                      available? (navic.is_available)]
                  (and available? (> (length (navic.get_location)) 0)))}
   {:update :CursorMoved
    :condition #(let [navic (require :nvim-navic)]
                  (navic.is_available))
    :provider #(let [navic (require :nvim-navic)]
                 (navic.get_location {:highlight true}))}])
