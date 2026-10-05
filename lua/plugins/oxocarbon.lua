-- [nfnl] fnl/plugins/oxocarbon.fnl
local option = vim.opt
local colorscheme = vim.cmd.colorscheme
local function _1_()
  option.background = "dark"
  return colorscheme("oxocarbon")
end
return {"tokyob0t/oxocarbon.nvim", init = _1_, build = false}
