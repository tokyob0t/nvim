{:schema :hotpot/2
 :target :cache
 :atomic? false
 :verbose? true
 :compiler {:allowedGlobals (icollect [k _ (pairs _G)] k)
            :extra-compiler-env {: vim}
            :error-pinpoint false}}
