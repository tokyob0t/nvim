local mode_names = {
    n = 'RW',
    no = 'RO',
    nov = 'RO',
    noV = 'RO',
    ['no\22'] = 'RO',

    niI = 'RW',
    niR = 'RW',
    niV = 'RW',
    nt = 'RW',

    v = '**',
    vs = '**',
    V = '**',
    Vs = '**',
    ['\22'] = '**',
    ['\22s'] = '**',

    s = 'S',
    S = 'SL',
    ['\19'] = 'SL',

    i = '**',
    ic = '**',
    ix = '**',

    R = 'RA',
    Rc = 'RA',
    Rx = 'RA',

    Rv = 'RV',
    Rvc = 'RV',
    Rvx = 'RV',

    c = 'VIEX',
    cv = 'VIEX',

    r = 'r',
    rm = 'r',
    ['r?'] = 'r',

    ['!'] = '!',
    t = '',
}

local mode_groups = {
    n = 'normal',
    no = 'normal',
    nov = 'normal',
    noV = 'normal',
    ['no\22'] = 'normal',

    niI = 'normal',
    niR = 'normal',
    niV = 'normal',
    nt = 'normal',

    v = 'visual',
    vs = 'visual',
    V = 'visual',
    Vs = 'visual',
    ['\22'] = 'visual',
    ['\22s'] = 'visual',

    s = 'visual',
    S = 'visual',
    ['\19'] = 'visual',

    i = 'insert',
    ic = 'insert',
    ix = 'insert',

    R = 'replace',
    Rc = 'replace',
    Rx = 'replace',
    Rv = 'replace',
    Rvc = 'replace',
    Rvx = 'replace',

    c = 'command',
    cv = 'command',

    r = 'normal',
    rm = 'normal',
    ['r?'] = 'normal',

    ['!'] = 'normal',
    t = 'normal',
}

return function(...)
    return {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,

        static = {
            mode_names = mode_names,
            mode_groups = mode_groups,
        },

        provider = function(self)
            return '%2( ' .. self.mode_names[self.mode] .. ' %)'
        end,

        hl = function(self)
            local group = self.mode_groups[self.mode] or 'normal'

            return 'Status' .. group:sub(1, 1):upper() .. group:sub(2)
        end,

        update = {
            'ModeChanged',
            pattern = '*:*',
            callback = vim.schedule_wrap(function()
                vim.cmd('redrawstatus')
            end),
        },
    }
end
