---@param args { format?: string, enable_file_icon?: boolean, readonly_icon?: string, modified_icon?: string }
return function(args)
    if args.format == nil then
        args.format = ':t'
    end

    local FileIcon = args.enable_file_icon
        and {
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
        }

    local FileName = {
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, args.format)

            if filename ~= '' then
                return string.format(' %s ', filename)
            end
        end,
    }

    local ModifiedFlag = args.modified_icon
        and {
            provider = args.modified_icon .. ' ',
            condition = function()
                return vim.bo.modified
            end,
        }

    local ReadonlyFlag = args.readonly_icon
        and {
            provider = args.readonly_icon .. ' ',
            condition = function()
                return not vim.bo.modifiable or vim.bo.readonly
            end,
        }

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
        FileIcon,
        FileName,
        ReadonlyFlag,
        ModifiedFlag,
    }
end
