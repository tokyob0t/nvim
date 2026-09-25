-- unstaged = '',
--
-- staged = '',
-- unmerged = '',
-- untracked = '',
-- renamed = '',
-- deleted = '',
-- ignored = '',

---@param args { format?: string, editable_icon?: boolean , file_icon?: boolean }
return function(args)
    if args.format == nil then
        args.format = ':t'
    end

    if args.file_icon == nil then
        args.file_icon = false
    end

    if args.editable_icon == nil then
        args.editable_icon = false
    end

    return {
        update = {
            'BufEnter',
            'BufWinEnter',
            'BufModifiedSet',
            'BufWritePost',
            'OptionSet',
        },

        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
            self.extension = vim.fn.fnamemodify(self.filename, ':e')
        end,

        args.file_icon and {
            init = function(self)
                self.icon, self.icon_color =
                    require('nvim-web-devicons').get_icon_color(self.filename, self.extension)
            end,
            provider = function(self)
                return self.icon and (self.icon .. ' ')
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end,
        },
        {
            provider = function(self)
                local filename = vim.fn.fnamemodify(self.filename, args.format)

                if filename ~= '' then
                    return string.format(' %s ', filename)
                end
            end,
        },
        args.editable_icon and {
            provider = ' ',
            condition = function()
                return vim.bo.modified
            end,
        },
        args.editable_icon and {
            provider = '  ',
            condition = function()
                return not vim.bo.modifiable or vim.bo.readonly
            end,
        },
    }
end
