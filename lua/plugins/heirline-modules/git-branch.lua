---@param args { format?: string }
return function(args)
    if not args.format then
        args.format = ' #%s '
    end

    return {
        update = {
            'BufEnter',
            'User',
            pattern = { 'GitSignsUpdate', 'GitSignsChanged' },
        },
        condition = function()
            return require('heirline.conditions').is_git_repo()
        end,

        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0
                or self.status_dict.removed ~= 0
                or self.status_dict.changed ~= 0
        end,

        hl = { bold = true },

        provider = function(self)
            return string.format(args.format, self.status_dict.head)
        end,
    }
end
