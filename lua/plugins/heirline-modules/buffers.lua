local Icons = require('icons')

local MODIFIED = ''
local READONLY = ''

local TablineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]

        if not win then
            return false
        end

        local bufnr = vim.api.nvim_win_get_buf(win)
        if not vim.api.nvim_buf_is_valid(bufnr) then
            return false
        end
        if vim.bo[bufnr].filetype == 'NvimTree' then
            self.winid = win
            return true
        end
        return false
    end,
    provider = function(self)
        local title = 'Files'
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.max(0, math.ceil((width - #title) / 2))
        return string.rep(' ', pad) .. title .. string.rep(' ', pad)
    end,
    hl = function(self)
        if vim.api.nvim_tabpage_list_wins(0)[1] == self.winid then
            return 'TabLineSel'
        end
        return 'TabLine'
    end,
}

---@param args { editable_icon?: boolean }
return function(args)
    local ReadonlyFlag = args.editable_icon
        and {
            condition = function(self)
                return not vim.api.nvim_get_option_value('modifiable', { buf = self.bufnr })
                    or vim.api.nvim_get_option_value('readonly', { buf = self.bufnr })
            end,

            provider = function(self)
                if vim.api.nvim_get_option_value('buftype', { buf = self.bufnr }) == 'terminal' then
                    return ' ' .. Icons.common.terminal
                end

                return ' ' .. READONLY
            end,
        }

    local ModifiedFlag = args.editable_icon
        and {
            provider = ' ' .. MODIFIED,
            condition = function(self)
                return vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
            end,
        }

    local TablineFile = {
        init = function(self)
            self.lfilename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ':.'))

            if self.lfilename == '' then
                self.lfilename = 'No Name'
            end
        end,
        provider = function(self)
            return '[' .. self.lfilename .. ']'
        end,
        hl = function(self)
            return { bold = self.is_active or self.is_visible }
        end,
    }

    local TablineFileNameBlock = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        end,
        hl = function(self)
            if self.is_active then
                return 'TabLineSel'
            end

            return 'TabLine'
        end,
        on_click = {
            name = 'heirline_tabline_buffer_callback',
            callback = vim.schedule_wrap(function(_, minwid, _, button)
                if button == 'm' then
                    vim.api.nvim_buf_delete(minwid, { force = false })
                    vim.cmd.redrawtabline()
                else
                    vim.api.nvim_win_set_buf(0, minwid)
                end
            end),
            minwid = function(self)
                return self.bufnr
            end,
        },
        TablineFile,
        ReadonlyFlag,
        ModifiedFlag,
    }

    local BufferLine = {
        init = function(self)
            self.bufferline =
                self:new(require('heirline.utils').make_buflist(TablineFileNameBlock), 1)

            print(self.new)
        end,
        provider = function(self)
            return self.bufferline:eval()
        end,
    }

    return {
        TablineOffset,
        BufferLine,
    }
end
