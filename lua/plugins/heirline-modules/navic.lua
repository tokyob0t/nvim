local CurrentFile = require('plugins.heirline-modules.current-file')
local Icons = require('icons')

--- TODO: improve
return function(...)
    return {
        -- hl = 'Normal',
        CurrentFile {
            format = ':t:r',
            enable_file_icon = true,
        },
        {
            provider = Icons.common.chevron_right .. ' ',
            update = 'CursorMoved',
            hl = 'NavicSeparator',
            condition = function()
                local navic = require('nvim-navic')

                return navic.is_available() and #navic.get_location() > 0
            end,
        },
        {
            update = 'CursorMoved',
            condition = function()
                return require('nvim-navic').is_available()
            end,
            provider = function()
                return require('nvim-navic').get_location { highlight = true }
            end,
        },
    }
end
