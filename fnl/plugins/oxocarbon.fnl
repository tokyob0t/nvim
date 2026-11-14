(import-macros {: colorscheme : custom-set-face! : set!} :macros)

{1 :tokyob0t/oxocarbon.nvim
 :build false
 :init #(let [{: oxocarbon} (require :oxocarbon)]
         (set! background :dark)
         (colorscheme oxocarbon)
         (custom-set-face! :WinBar [] {:bg oxocarbon.none})
         (custom-set-face! :StatusLineDiagnosticWarn [:bold] {:fg oxocarbon.base14 :bg oxocarbon.base00})
         (custom-set-face! :StatusLineDiagnosticError [:bold] {:fg oxocarbon.base08 :bg oxocarbon.base00}))}
