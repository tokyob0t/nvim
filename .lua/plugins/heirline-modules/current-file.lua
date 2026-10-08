-- [nfnl] fnl/plugins/heirline-modules/current-file.fnl
local function FileIcon(file_icon)
  if file_icon then
    local function _1_(_241)
      local self = _241
      local devicons = require("nvim-web-devicons")
      local _set_2_ = devicons.get_icon_color(self.filename, self.extension)
      self.icon = _set_2_[1]
      self.icon_color = _set_2_[2]
      return nil
    end
    local function _3_(self)
      if self.icon then
        return (self.icon .. " ")
      else
        return nil
      end
    end
    local function _6_(_5_)
      local icon_color = _5_.icon_color
      return {fg = icon_color}
    end
    return {init = _1_, provider = _3_, hl = _6_}
  else
    return nil
  end
end
local function FileName(filename, format)
  local function _8_(self)
    local filename0 = vim.fn.fnamemodify(self.filename, format)
    if (filename0 ~= "") then
      return string.format(" %s ", filename0)
    else
      return nil
    end
  end
  return {provider = _8_}
end
local function ModifiedFlag(modified_icon)
  if modified_icon then
    local function _10_()
      return vim.bo.modified
    end
    return {condition = _10_, provider = (modified_icon .. " ")}
  else
    return nil
  end
end
local function ReadonlyFlag(readonly_icon)
  if readonly_icon then
    local function _12_()
      return not (vim.bo.modifiable or vim.bo.readonly)
    end
    return {provider = (readonly_icon .. " "), condition = _12_}
  else
    return nil
  end
end
local function _15_(_14_)
  local format = _14_.format
  local enable_file_icon = _14_["enable-file-icon"]
  local readonly_icon = _14_["readonly-icon"]
  local modified_icon = _14_["modified-icon"]
  local format0 = (format or ":t")
  local EVENTS = {"BufEnter", "BufWinEnter", "BufModifiedSet", "BufWritePost", "OptionSet"}
  local function _16_(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    self.extension = vim.fn.fnamemodify(self.filename, ":e")
    return nil
  end
  return {update = EVENTS, init = _16_, [{1}] = FileIcon(enable_file_icon), [{2}] = FileName(nil, format0), [{3}] = ReadonlyFlag(readonly_icon), [{4}] = ModifiedFlag(modified_icon)}
end
return _15_
