return function(name, description, callback)
    return vim.api.nvim_create_user_command(name, callback, {
        desc = description,
    })
end
