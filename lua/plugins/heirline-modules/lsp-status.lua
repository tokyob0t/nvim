return function(...)
    return {
        update = { 'LspAttach', 'LspDetach' },
        condition = function()
            return require('heirline.conditions').lsp_attached()
        end,
        provider = function()
            local names = {}
            for i, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
                table.insert(names, server.name)
            end
            return ' [ ' .. table.concat(names, ' ') .. ' ] '
        end,
    }
end
