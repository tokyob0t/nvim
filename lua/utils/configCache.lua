-- Hotpot compiles every fnl file to Lua under stdpath('data') and keeps the
-- result fresh on save. Booting straight from that directory avoids loading
-- the 300 KB Fennel compiler on every start, but the compiled files are only
-- trustworthy while they are at least as new as the sources.
local M = {}

local uv = vim.uv or vim.loop

function M.dir()
    return vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'hotpot', 'opt', 'hotpot-config-cache')
end

local function newer(a, b)
    if a.mtime.sec ~= b.mtime.sec then
        return a.mtime.sec > b.mtime.sec
    end
    return (a.mtime.nsec or 0) > (b.mtime.nsec or 0)
end

--- True when every fnl file under `<config>/fnl` has a compiled twin in
--- `<dir>/lua` that is not older than the source.
function M.fresh(dir, config)
    local root = vim.fs.joinpath(config, 'fnl')
    local compiled_root = vim.fs.joinpath(dir, 'lua')

    if not uv.fs_stat(root) or not uv.fs_stat(compiled_root) then
        return false
    end

    for path, kind in vim.fs.dir(root, { depth = 10 }) do
        if kind == 'file' and path:sub(-4) == '.fnl' then
            local source = uv.fs_stat(vim.fs.joinpath(root, path))
            local compiled = uv.fs_stat(vim.fs.joinpath(compiled_root, (path:gsub('%.fnl$', '.lua'))))
            if not compiled or (source and newer(source, compiled)) then
                return false
            end
        end
    end

    return true
end

return M
