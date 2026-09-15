return function(...)
    return {
        init = function(self)
            local search = vim.fn.getreg('/')

            if search ~= '' and vim.v.hlsearch == 1 then
                local ok, count = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })

                if not ok then
                    self.search_count = nil
                    return
                end

                if count and count.total > 0 then
                    self.search_count = string.format('[%d/%d]', count.current, count.total)
                    return
                end
            end
            self.search_count = nil
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
