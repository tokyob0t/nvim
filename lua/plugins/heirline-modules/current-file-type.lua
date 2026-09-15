return function(...)
    return {
        update = {
            'BufEnter',
            'BufWinEnter',
            -- 'BufRename',
            'BufModifiedSet',
            'BufWritePost',
            'OptionSet',
        },
        provider = function()
            return ' ' .. vim.bo.filetype .. ' '
        end,
    }
end
