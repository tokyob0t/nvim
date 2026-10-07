{:schema :hotpot/2
 :target :cache
 :atomic? false
 ;; Optional, boolean
 ;; If true (default: false), output messages after every successful
 ;; compilation instead of just on error.
 :verbose? true
 :ignore []
 :compiler {:allowedGlobals (icollect [k _ (pairs _G)] k)
            :extra-compiler-env {: vim}}}
