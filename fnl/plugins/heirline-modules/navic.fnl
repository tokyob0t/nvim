(local CurrentFile (require :plugins.heirline-modules.current-file))
(local Icons (require :icons))

(fn Separator []
  {:update :CursorMoved
   :hl :NavicSeparator
   :condition #(let [navic (require :nvim-navic)
                     available? (navic.is_available)]
                 (and available? (> (length (navic.get_location)) 0)))
   :provider (.. Icons.common.chevron_right " ")})

(fn Navic []
  {:update :CursorMoved
   :condition #(let [navic (require :nvim-navic)]
                 (navic.is_available))
   :provider #(let [navic (require :nvim-navic)]
                (navic.get_location {:highlight true}))})

(fn [...]
  [(CurrentFile {:enable_file_icon true :format ":t:r"}) (Separator) (Navic)])
