(local icons (require :icons))

{1 :lukas-reineke/indent-blankline.nvim
 :main :ibl
 :opts {:indent {:char icons.indent}
        :scope {:exclude {:language [:fennel :clojure :lisp :racket :scheme]}
                :highlight ["@constant.builtin"
                            "@punctuation.bracket"
                            :Keyword
                            :DiagnosticError
                            :Todo
                            :String
                            :Number]}}}
