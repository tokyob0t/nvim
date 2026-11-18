-- Hotpot compiles every spec to Lua in its cache. Booting 24 separate files
-- costs more than one bundle: this concatenates them into a single chunk that
-- registers each spec in package.preload, mirrors the trick Fennel's
-- --require-as-include uses. The bundle lives in the cache dir because hotpot
-- deletes files it does not own from its own cache.
local M = {}

function M.bundle_path()
    return vim.fs.joinpath(vim.fn.stdpath('cache'), 'specs-bundle.lua')
end

function M.manifest_path()
    return vim.fs.joinpath(vim.fn.stdpath('cache'), 'specs-bundle.manifest')
end

--- 'plugins.foo.bar' for 'foo/bar.lua'
local function module_name(rel)
    return 'plugins.' .. rel:gsub('%.lua$', ''):gsub('/', '.')
end

local function source_dir()
    return vim.fs.joinpath(require('utils.configCache').dir(), 'lua', 'plugins')
end

--- Compiled specs currently in the hotpot cache, sorted by path.
--- Recursive on purpose: a spec in a subdirectory compiles to a nested .lua.
local function sources()
    local dir = source_dir()
    local items = {}
    for name, kind in vim.fs.dir(dir, { depth = 10 }) do
        if kind == 'file' and name:sub(-4) == '.lua' then
            local path = vim.fs.joinpath(dir, name)
            local stat = vim.uv.fs_stat(path)
            if stat then
                items[#items + 1] = { name = name, path = path, mtime = stat.mtime }
            end
        end
    end
    table.sort(items, function(a, b)
        return a.name < b.name
    end)
    return items
end

--- True when the bundle lists exactly the specs on disk, with the same mtimes.
function M.fresh()
    local items = sources()
    local file = io.open(M.manifest_path(), 'r')
    if not file then
        return false
    end
    local seen = 0
    for line in file:lines() do
        seen = seen + 1
        local item = items[seen]
        local name, sec, nsec = line:match('^(.-)\t(%d+)\t(%d+)$')
        if
            not item
            or name ~= item.name
            or tonumber(sec) ~= item.mtime.sec
            or tonumber(nsec) ~= item.mtime.nsec
        then
            file:close()
            return false
        end
    end
    file:close()
    return seen == #items
end

function M.build()
    local items = sources()
    if #items == 0 then
        return false
    end

    local parts, manifest, names = {}, {}, {}
    for _, item in ipairs(items) do
        local modname = module_name(item.name)
        local source = table.concat(vim.fn.readfile(item.path), '\n')
        parts[#parts + 1] =
            string.format('package.preload[%q] = function(...)\n%s\nend', modname, source)
        manifest[#manifest + 1] =
            string.format('%s\t%d\t%d', item.name, item.mtime.sec, item.mtime.nsec)
        names[#names + 1] = string.format('require(%q),', modname)
    end
    parts[#parts + 1] = 'return {\n' .. table.concat(names, '\n') .. '\n}\n'

    local bundle = assert(io.open(M.bundle_path(), 'w'))
    bundle:write(table.concat(parts, '\n'))
    bundle:close()

    local manifest_file = assert(io.open(M.manifest_path(), 'w'))
    manifest_file:write(table.concat(manifest, '\n') .. '\n')
    manifest_file:close()

    return true
end

--- Module names of the compiled specs, in the same order the bundle uses.
function M.names()
    local names = {}
    for _, item in ipairs(sources()) do
        names[#names + 1] = module_name(item.name)
    end
    return names
end

--- The list of plugin specs, or nil when the bundle cannot be used.
function M.load()
    if not M.fresh() then
        local ok = pcall(M.build)
        if not ok then
            return nil
        end
    end

    local chunk = loadfile(M.bundle_path())
    if not chunk then
        return nil
    end

    local ok, specs = pcall(chunk)
    if not ok or type(specs) ~= 'table' then
        return nil
    end

    return specs
end

return M
