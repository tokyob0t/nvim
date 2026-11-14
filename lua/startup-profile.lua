-- Times every Lua require from the top of init.lua until UIEnter, so the
-- dashboard and :StartupTime can show where the startup budget went.
--
-- This only observes; it returns exactly what the original require returned.
-- Requires coming from Vimscript, from `plugin/` scripts and from Neovim
-- itself before init.lua are not covered, use --startuptime for those.
local M = {}

local hrtime = vim.uv.hrtime

local orig_require
local installed = false
local start_ns
local stack = {}
local records = {}

local function ms_since(start)
    return (hrtime() - start) / 1e6
end

function M.install()
    if installed then
        return
    end
    installed = true
    start_ns = hrtime()
    orig_require = _G.require

    _G.require = function(name)
        local started = hrtime()
        local frame = { name = name, child = 0 }
        stack[#stack + 1] = frame

        -- pcall only so the frame is popped on errors; the error is rethrown
        -- untouched (level 0) so callers still see the original message
        local ok, a, b, c = pcall(orig_require, name)

        stack[#stack] = nil
        local ms = ms_since(started)
        local parent = stack[#stack]
        if parent then
            parent.child = parent.child + ms
        end

        records[#records + 1] = {
            name = name,
            ms = ms,
            self_ms = ms - frame.child,
            depth = #stack + 1,
            ok = ok,
        }

        if not ok then
            error(a, 0)
        end
        return a, b, c
    end
end

function M.uninstall()
    if installed and orig_require then
        _G.require = orig_require
        installed = false
    end
end

function M.installed()
    return installed
end

function M.records()
    return records
end

--- Milliseconds since the hook was installed (or since vim.g.startup_t0).
function M.start_ms()
    if start_ns then
        return start_ns / 1e6
    end
    local t0 = vim.g.startup_t0 or vim.g['startup-t0']
    return t0 and (t0 / 1e6) or nil
end

--- Milliseconds since startup, or nil when no start time is available.
function M.elapsed_ms()
    local start = M.start_ms()
    if start then
        return (hrtime() / 1e6) - start
    end
end

return M
