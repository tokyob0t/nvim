return function(...)
    local Severity = vim.diagnostic.severity
    local cfg = vim.diagnostic.config()

    return {
        update = { 'DiagnosticChanged', 'BufEnter' },

        condition = function()
            return require('heirline.conditions').has_diagnostics()
        end,

        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = Severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = Severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = Severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = Severity.INFO })
        end,

        static = {
            error_icon = cfg.signs.text[Severity.ERROR],
            warn_icon = cfg.signs.text[Severity.WARN],
            info_icon = cfg.signs.text[Severity.INFO],
            hint_icon = cfg.signs.text[Severity.HINT],
        },

        {
            -- hl = 'DiagnosticWarn',
            hl = 'StatusLineDiagnosticWarn',
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. ' ' .. self.warnings .. ' ')
            end,
        },

        {
            -- hl = 'DiagnosticError',
            -- hl = 'StatusLineDiagnosticError',
            hl = 'StatusLineDiagnosticError',
            provider = function(self)
                return self.errors > 0 and (' ' .. self.error_icon .. ' ' .. self.errors .. ' ')
            end,
        },

        -- {
        --     hl = 'DiagnosticInfo',
        --     provider = function(self)
        --         return self.info > 0 and (self.info_icon .. ' ' .. self.info .. ' ')
        --     end,
        -- },

        -- {
        --     hl = 'DiagnosticHint',
        --     provider = function(self)
        --         return self.hints > 0 and (self.hint_icon .. ' ' .. self.hints .. ' ')
        --     end,
        -- },
    }
end
