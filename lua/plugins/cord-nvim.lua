-- [nfnl] fnl/plugins/cord-nvim.fnl
local function _2_(_1_)
  local filename = _1_.filename
  local cursor_line = _1_.cursor_line
  local cursor_char = _1_.cursor_char
  return ("Editing" .. filename .. "-" .. cursor_line .. ":" .. cursor_char)
end
return {"vyfor/cord.nvim", opts = {advanced = {discord = {reconnect = {enabled = true}}}, text = {editing = _2_}}}
