local CurrentFile = require('plugins.heirline-modules.current-file')

--- TODO: improve
return function()
    return {
        {
            provider = '     ',
        },
        CurrentFile {
            format = ':t:r',
            file_icon = true,
        },
        {
            provider = ' ',
            update = 'CursorMoved',
            hl = 'NavicSeparator',
            condition = function()
                local available = require('nvim-navic').is_available()

                if not available then
                    return false
                end

                local location = require('nvim-navic').get_location()

                return #location > 0
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
