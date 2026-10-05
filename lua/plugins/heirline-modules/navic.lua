-- [nfnl] fnl/plugins/heirline-modules/navic.fnl
local CurrentFile = require("plugins.heirline-modules.current-file")
local Icons = require("icons")
local function Separator()
  local function _1_()
    local navic = require("nvim-navic")
    local available_3f = navic.is_available()
    return (available_3f and (#navic.get_location() > 0))
  end
  return {update = "CursorMoved", hl = "NavicSeparator", condition = _1_, provider = (Icons.common.chevron_right .. " ")}
end
local function Navic()
  local function _2_()
    local navic = require("nvim-navic")
    return navic.is_available()
  end
  local function _3_()
    local navic = require("nvim-navic")
    return navic.get_location({highlight = true})
  end
  return {update = "CursorMoved", condition = _2_, provider = _3_}
end
local function _4_(...)
  return {CurrentFile({enable_file_icon = true, format = ":t:r"}), Separator(), Navic()}
end
return _4_
