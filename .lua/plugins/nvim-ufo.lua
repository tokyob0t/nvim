-- [nfnl] fnl/plugins/nvim-ufo.fnl
local function _1_(_, _0, _1)
  return {"treesitter", "indent"}
end
local function _2_(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" \239\149\129 %d "):format((endLnum - lnum))
  local curWidth = 0
  for i, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if ((curWidth + chunkWidth) > width) then
      table.insert(newVirtText, {truncate(chunkText, (width - curWidth - suffix)), chunk[2]})
      curWidth = (curWidth + vim.fn.strdisplaywidth(newVirtText[#newVirtText], 1))
    else
      table.insert(newVirtText, chunk)
      curWidth = (curWidth + chunkWidth)
    end
  end
  table.insert(newVirtText, {suffix, "MoreMsg"})
  return newVirtText
end
return {[{1}] = "kevinhwang91/nvim-ufo", dependencies = {{[{1}] = "kevinhwang91/promise-async"}}, event = "VeryLazy", opts = {provider_selector = _1_, fold_virt_text_handler = _2_}}
