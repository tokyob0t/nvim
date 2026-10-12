{:schema :hotpot/2
 :atomic? true
 :verbose? true
 :compiler {:allowedGlobals (icollect [k _ (pairs _G)] k)
            :extra-compiler-env {: vim}
            :error-pinpoint false}}
