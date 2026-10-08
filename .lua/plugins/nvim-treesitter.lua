-- [nfnl] fnl/plugins/nvim-treesitter.fnl
local parsers = {"lua", "python", "vim", "html", "html_tags", "javascript", "css", "scss", "vimdoc", "bash", "markdown", "rust", "xml", "json", "meson", "toml", "gitignore", "gitcommit", "git_config", "comment"}
local function _1_()
  local ts = require("nvim-treesitter")
  ts.install(parsers):wait(300000)
  local function _3_(_2_)
    local buf = _2_.buf
    return pcall(vim.treesitter.start, buf)
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _3_})
end
local function _4_()
end
return {"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", config = _1_, init = _4_, lazy = false}
