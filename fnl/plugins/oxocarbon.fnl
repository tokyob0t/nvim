(import-macros {: colorscheme : set!} :macros)

{1 :tokyob0t/oxocarbon.nvim
 :build false
 :init #(do
          (set! background :dark)
          (colorscheme oxocarbon))}
