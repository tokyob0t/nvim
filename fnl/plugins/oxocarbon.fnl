(import-macros {: custom-set-face! : set!} :macros)

{1 :tokyob0t/oxocarbon.nvim
 :build false
 ;; the module is the whole colorscheme: requiring it applies all 479 groups.
 ;; `:colorscheme oxocarbon` is not used because colors/oxocarbon.lua clears the
 ;; module before requiring it, which runs the same 479 nvim_set_hl calls a
 ;; second time for no visual difference.
 :init #(do
         (set! background :dark)
         (let [{: oxocarbon} (require :oxocarbon)]
          (custom-set-face! :WinBar [] {:bg oxocarbon.none})
          (custom-set-face! :StatusLineDiagnosticWarn [:bold] {:fg oxocarbon.base14 :bg oxocarbon.base00})
          (custom-set-face! :StatusLineDiagnosticError [:bold] {:fg oxocarbon.base08 :bg oxocarbon.base00})))}
