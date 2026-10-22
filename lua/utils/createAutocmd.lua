return function(events, pattern, callback)
    return vim.api.nvim_create_autocmd(events, {
        pattern = pattern,
        callback = callback,
    })
end
