-- [nfnl] fnl/plugins/blink-cmp.fnl
local Icons = require("icons")
local options = vim.opt
local function getKindIconText(ctx)
  local devicons = require("nvim-web-devicons")
  if vim.tbl_contains({"Path"}, ctx.source_name) then
    return (" " .. tostring(devicons.get_icon(ctx.label)) .. tostring(ctx.icon_gap) .. " ")
  else
    return (tostring(ctx.kind_icon) .. tostring(ctx.icon_gap))
  end
end
local function getKindIconHighlight(ctx)
  local devicons = require("nvim-web-devicons")
  local hl = ctx.kind_hl
  if vim.tbl_contains({"Path"}, ctx.source_name) then
    local dev_icon, dev_hl = devicons.get_icon(ctx.label)
    if dev_icon then
      hl = dev_hl
    else
    end
  else
  end
  return hl
end
local function _4_()
  options.completeopt = {"menu", "menuone", "noselect"}
  return nil
end
local function _5_(ctx)
  return ctx.label
end
local function _6_(ctx)
  return ("[" .. ctx.source_name .. "]")
end
return {"saghen/blink.cmp", dependencies = {"saghen/blink.lib", "rafamadriz/friendly-snippets", "nvim-tree/nvim-web-devicons"}, init = _4_, opts_extend = {"sources.default"}, opts = {keymap = {preset = "enter", ["<Tab>"] = {"select_next", "fallback"}, ["<S-Tab>"] = {"select_prev", "fallback"}}, appearance = {nerd_font_variant = "mono", kind_icons = Icons.kinds}, sources = {default = {"lsp", "path", "snippets", "buffer"}}, fuzzy = {implementation = "lua"}, completion = {documentation = {auto_show = true}, ghost_text = {enabled = true, show_without_selection = true}, list = {selection = {preselect = false}}, menu = {draw = {padding = {0, 1}, columns = {{"kind_icon"}, {gap = 1, width = 30, label = "source_name"}}, components = {kind_icon = {text = getKindIconText, highlight = getKindIconHighlight}, label = {width = {fill = true, max = 30}, text = _5_}, source_name = {width = {max = 20}, text = _6_}}}}}, cmdline = {enabled = true, keymap = {preset = "inherit"}, sources = {default = {"cmdline", "buffer"}}, completion = {list = {selection = {preselect = false}}, menu = {auto_show = true}, ghost_text = {enabled = true, show_without_selection = true}, documentation = {auto_show = true}}}, term = {keymap = {preset = "inherit"}, sources = {}, enabled = false}}}
