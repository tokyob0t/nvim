-- [nfnl] fnl/modules/lazy.fnl
local Icons = require("icons")
local variables = vim.v
local function handle_error(err)
  vim.api.nvim_echo({{err, "ErrorMsg"}, {"\nPress any key to exit...", "WarningMsg"}}, true, {})
  vim.fn.getchar()
  return os.exit(1)
end
local function git_clone(repo_url, branch, clone_path)
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", ("--branch=" .. branch), repo_url, clone_path})
  if (variables.shell_error ~= 0) then
    return error(("Failed to clone " .. repo_url .. ":\n" .. out))
  else
    return nil
  end
end
local function install_plugin(plugin, branch)
  local _, repo = string.match(plugin, "(.+)/(.+)")
  local repo_path = (vim.fn.stdpath("data") .. "/lazy/" .. repo)
  if not vim.uv.fs_stat(repo_path) then
    vim.notify(("Installing " .. plugin .. " " .. branch))
    git_clone(("https://github.com/" .. plugin .. ".git"), branch, repo_path)
  else
  end
  return vim.opt.rtp:prepend(repo_path)
end
install_plugin("folke/lazy.nvim", "stable")
local lazy = require("lazy")
return lazy.setup({change_detection = {enabled = false}, checker = {enabled = true, notify = false}, install = {colorscheme = {"oxocarbon"}}, spec = {{import = "plugins"}}, ui = {border = "solid", icons = {cmd = Icons.common.terminal, favorite = Icons.common.bookmark, keys = Icons.common.keymap, lazy = Icons.common.lazy, loaded = Icons.package.installed, not_loaded = Icons.package.pending, plugin = Icons.common.plugin, require = Icons.common.lua, source = Icons.common.source}, size = {height = 0.9, width = 0.8}, title = "lazy.nvim", title_pos = "center"}})
