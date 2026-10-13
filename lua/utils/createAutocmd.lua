return function(events, callback)
    return vim.api.nvim_create_autocmd(events, {
        callback = callback,
    })
end
