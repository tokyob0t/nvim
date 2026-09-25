local variables = vim.v

return function(...)
    return {
        init = function(self)
            local search = vim.fn.getreg('/')

            if not (search ~= '' and variables.hlsearch == 1) then
                self.search_count = nil
                return
            end

            local ok, count = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })

            if ok and (count and count.total > 0) then
                self.search_count = '[' .. count.current .. '/' .. count.total .. ']'
            else
                self.search_count = nil
            end
        end,

        provider = function(self)
            if self.search_count then
                return ' ' .. self.search_count .. ' '
            end

            return ' %l:%c '
        end,

        update = {
            'CursorMoved',
            'CursorMovedI',
            'CmdlineLeave',
            'BufEnter',
        },
    }
end
