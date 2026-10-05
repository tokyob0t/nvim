{[1] :windwp/nvim-autopairs
 :event :InsertEnter
 :opts {:check_ts true
        :ts_config {:lua [:string :source]
                    :javascript [:string :template_string]
                    :java false}
        :map_cr true
        :map_bs true
        :fast_wrap {:map :<M-e>
                    :chars ["{" "[" "(" "\"" "'" "`"]
                    :pattern (string.gsub "[%'%\"%`%(%{%[]+" "%s+" "")
                    :end_key "$"
                    :before_key :h
                    :after_key :l
                    :cursor_pos_before true
                    :keys :qwertyuiopzxcvbnmasdfghjkl
                    :highlight :PmenuSel
                    :highlight_grey :LineNr}}}
