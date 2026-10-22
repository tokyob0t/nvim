function table.filter(tbl, fn)
    return vim.tbl_filter(fn, tbl)
end

function table.keys(tbl)
    return vim.tbl_keys(tbl)
end
