-- [nfnl] fnl/plugins/heirline-nvim.fnl
local options = vim.opt
local create_autocmd = vim.api.nvim_create_autocmd
local get_option_value = vim.api.nvim_get_option_value
local icons = require("icons")
local Navic = require("plugins.heirline-modules.navic")
local VimMode = require("plugins.heirline-modules.vim-mode")
local CurrentFile = require("plugins.heirline-modules.current-file")
local Diagnostics = require("plugins.heirline-modules.diagnostics")
local CursorPosition = require("plugins.heirline-modules.cursor-position")
local LSPStatus = require("plugins.heirline-modules.lsp-status")
local GitBranch = require("plugins.heirline-modules.git-branch")
local CurrentFileType = require("plugins.heirline-modules.current-file-type")
local Buffers = require("plugins.heirline-modules.buffers")
local DEFAULT_EXCLUDED_FILETYPES = {"NvimTree.*", "Telescope.*", "dashboard"}
local function WinBar(_1_)
  local excluded_filetypes = _1_.excluded_filetypes
  local args = _1_
  local function _2_(_241)
    local excluded_filetypes0 = _241.excluded_filetypes
    local conditions = require("heirline.conditions")
    return not conditions:buffer_matches({filetype = excluded_filetypes0})
  end
  return {{unpack(args)}, static = {excluded_filetypes = (excluded_filetypes or DEFAULT_EXCLUDED_FILETYPES)}, condition = _2_}
end
local function _3_()
  local EVENTS = {"BufEnter", "TabEnter", "BufAdd", "BufDelete", "BufModifiedSet", "BufWritePost"}
  options.showtabline = 0
  vim.api.nvim_set_hl(0, "WinBar", {bg = "NONE"})
  local function _4_()
    local count
    local function _5_(bufnr)
      return get_option_value("buflisted", {buf = bufnr})
    end
    count = #vim.tbl_filter(_5_, vim.api.nvim_list_bufs())
    options.showtabline = (((count >= 2) and 2) or 0)
    return vim.cmd.redrawtabline()
  end
  return create_autocmd(EVENTS, {callback = vim.schedule_wrap(_4_)})
end
local function _6_(_241)
  local buf = _241.buf
  local conditions = require("heirline.conditions")
  return conditions:buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugitive", "Trouble", "dashboard"}}, buf)
end
return {"rebelot/heirline.nvim", dependencies = {"SmiteshP/nvim-navic"}, event = "UiEnter", init = _3_, opts = {opts = {disable_winbar_cb = _6_}, statusline = WinBar({VimMode({}), CurrentFile({format = ":t", modified_icon = icons.tree.git.unstaged, readonly_icon = icons.tree.git.ignored, enable_file_icon = false}), GitBranch({format = "(\206\187 \226\128\162 #%s)"}), {provider = "%="}, Diagnostics({error_icon = icons.diagnostics.error, hint_icon = icons.diagnostics.hint, info_icon = icons.diagnostics.info, warn_icon = icons.diagnostics.warn}), CurrentFileType({}), CursorPosition({})}), tabline = WinBar({Buffers({modified_icon = icons.tree.git.unstaged, readonly_icon = icons.tree.git.ignored}), excluded_filetypes = {}}), winbar = WinBar({Navic({})})}}
