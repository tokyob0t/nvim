-- [nfnl] fnl/plugins/heirline-modules/buffers.fnl
local icons = require("icons")
local function TablineOffset(_1_)
  local title = _1_.title
  local function _2_(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    if not win then
      return false
    else
    end
    local bufnr = vim.api.nvim_win_get_buf(win)
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return false
    elseif (vim.bo[bufnr].filetype == "NvimTree") then
      self.winid = win
      return true
    else
    end
    return false
  end
  local function _5_(_241)
    local winid = _241.winid
    if (vim.api.nvim_tabpage_list_wins(0)[1] == winid) then
      return "TabLineSel"
    else
      return "TabLine"
    end
  end
  local function _7_(_241)
    local winid = _241.winid
    local width = vim.api.nvim_win_get_width(winid)
    local pad = math.max(0, math.ceil(((width - #title) / 2)))
    return (string.rep(" ", pad) .. title .. string.rep(" ", pad))
  end
  return {condition = _2_, hl = _5_, provider = _7_}
end
local function ReadonlyFlag(_8_)
  local readonly_icon = _8_.readonly_icon
  if readonly_icon then
    local function _9_()
      return (not vim.bo.modifiable or vim.bo.readonly)
    end
    return {condition = _9_, provider = (args.readonly_icon .. " ")}
  else
    return nil
  end
end
local function ModifiedFlag(_11_)
  local modified_icon = _11_.modified_icon
  if modified_icon then
    local function _12_(self)
      return vim.api.nvim_get_option_value("modified", {buf = self.bufnr})
    end
    return {condition = _12_, provider = (modified_icon .. " ")}
  else
    return nil
  end
end
local function TablineFile()
  local function _14_(self)
    return {bold = (self.is_active or self.is_visible)}
  end
  local function _16_(_15_)
    local filename = _15_.filename
    local self = _15_
    self.lfilename = vim.fn.pathshorten(vim.fn.fnamemodify(filename, ":."))
    if (self.lfilename == "") then
      self.lfilename = "No Name"
      return nil
    else
      return nil
    end
  end
  local function _19_(_18_)
    local lfilename = _18_.lfilename
    return ("[" .. lfilename .. "]")
  end
  return {hl = _14_, init = _16_, provider = _19_}
end
local function BufferLine()
  local function _20_(_241)
    local self = _241
    local utils = require("heirline.utils")
    local bufferline = utils:make_buflist(__fnl_global__Tabline_2dfile_2dname_2dblock)
    self.bufferline = self:new(bufferline, 1)
    return nil
  end
  local function _22_(_21_)
    local bufferline = _21_.bufferline
    return bufferline:eval()
  end
  return {init = _20_, provider = _22_}
end
local function _23_(args)
  local Tabline_file_name_block
  local function _24_(self)
    if self.is_active then
      return "TabLineSel"
    else
      return "TabLine"
    end
  end
  local function _27_(_26_)
    local bufnr = _26_.bufnr
    local self = _26_
    self.filename = vim.api.nvim_buf_get_name(bufnr)
    return nil
  end
  local function _28_(_, minwid, _0, button)
    if (button == "m") then
      vim.api.nvim_buf_delete(minwid, {force = false})
      return vim.cmd.redrawtabline()
    else
      return vim.api.nvim_win_set_buf(0, minwid)
    end
  end
  local function _30_(self)
    return self.bufnr
  end
  Tabline_file_name_block = {TablineFile(), ReadonlyFlag(), ModifiedFlag(), hl = _24_, init = _27_, on_click = {callback = vim.schedule_wrap(_28_), minwid = _30_, name = "heirline_tabline_buffer_callback"}}
  return {TablineOffset({title = "Files"}), BufferLine}
end
return _23_
