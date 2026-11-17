-- Boots the config from the Lua that hotpot already compiled, loading the
-- Fennel compiler only when the cache is missing or behind the sources.

return {
    setup = function()
        local configCache = require('utils.configCache')
        local cache = configCache.dir()
        local config = vim.fn.stdpath('config')

        if not configCache.fresh(cache, config) then
            -- hotpot does not recompile just because a source is newer, so this is
            -- the only path that pays the compile cost
            require('utils.installPlugin')('hotpot', 'rktjmp/hotpot.nvim', 'main')
            local ok, err = pcall(function()
                local ctx = assert(require('hotpot.api').context(config))
                ctx.sync { ['verbose?'] = false }
            end)
            if not ok then
                vim.notify('hotpot sync failed: ' .. tostring(err), vim.log.levels.ERROR)
            end
        end

        vim.g.hotpot_cache_dir = cache
        vim.opt.rtp:prepend(cache)
    end,
}
