if vim.g.vscode then
    return
end

require('utils.startupProfile').install()

-- Hotpot already writes compiled Lua for every fnl file and keeps it fresh on
-- save, so boot straight from that cache and skip loading the Fennel compiler.
-- Fall back to hotpot when the cache is missing or older than the sources.
local configCache = require('utils.configCache')
local cache = configCache.dir()
local config = vim.fn.stdpath('config')

if configCache.fresh(cache, config) then
    vim.g.hotpot_cache_dir = cache
    vim.opt.rtp:prepend(cache)
else
    -- hotpot does not recompile just because a source is newer, so sync when
    -- the cache is behind; this is the only path that pays the compile cost
    local installPlugin = require('utils.installPlugin')
    installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')
    local ok, err = pcall(function()
        local ctx = assert(require('hotpot.api').context(config))
        ctx.sync { ['verbose?'] = false }
    end)
    if not ok then
        vim.notify('hotpot sync failed: ' .. tostring(err), vim.log.levels.ERROR)
    end
    vim.g.hotpot_cache_dir = cache
    vim.opt.rtp:prepend(cache)
end

-- Keep the cache fresh when editing fennel. Hotpot registers its own save hook
-- as soon as it is loaded, so only act while it is not.
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.fnl', '*.fnlm' },
    callback = function()
        if package.loaded['hotpot'] then
            return
        end
        local ok, err = pcall(function()
            require('utils.installPlugin')('hotpot', 'rktjmp/hotpot.nvim', 'main')
            local ctx = assert(require('hotpot.api').context(vim.fn.stdpath('config')))
            ctx.sync()
        end)
        if not ok then
            vim.notify('hotpot sync failed: ' .. tostring(err), vim.log.levels.ERROR)
        end
    end,
})

require('modules')
