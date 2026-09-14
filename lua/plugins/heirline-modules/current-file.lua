return function(...)
    local FileNameModifer = {
        hl = function()
            if vim.bo.modified then
                return { fg = 'cyan', bold = true, force = true }
            end
        end,
    }

    return {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
        provider = function(self)
            return ' ' .. vim.fn.fnamemodify(self.filename, ':t')
        end,
    }
end
