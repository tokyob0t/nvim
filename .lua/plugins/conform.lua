-- [nfnl] fnl/plugins/conform.fnl
local globals = vim.g
local create_user_command = vim.api.nvim_create_user_command
local function _1_()
  local function _2_()
    local global_state = globals.disable_autoformat
    local buffer_state = globals.disable_autoformat
    vim.b.disable_autoformat = not (global_state or buffer_state)
    return nil
  end
  return create_user_command("ToggleFormat", _2_, {desc = "Toggle autoformat-on-save"})
end
local function _3_(bufnr)
  if vim.b[bufnr].disable_autoformat then
    return 
  else
  end
  return {lsp_format = "fallback", timeout_ms = 1000}
end
return {"stevearc/conform.nvim", cmd = "ConformInfo", event = "BufWritePre", init = _1_, opts = {format_after_save = _3_, formatters = {kdlfmt = {append_args = {"--kdl-version", "v1"}}}, formatters_by_ft = {c = {"clang-format"}, ["c++"] = {"clang-format"}, css = {"prettierd"}, fennel = {"fnlfmt"}, go = {"gofumpt", "golines", "goimports", "goimports-reviser", "gomodifytags"}, html = {"prettierd"}, javascript = {"biome"}, json = {"biome"}, kdl = {"kdlfmt"}, lua = {"stylua"}, nix = {"nixpkgs-fmt", "nixfmt"}, python = {"isort", "autoflake", "yapf"}, sass = {"prettierd"}, scss = {"prettierd"}, sh = {"beautysh"}, sql = {"sqlfmt", "sleek"}, toml = {"taplo"}, tsx = {"biome"}, typescript = {"biome"}, xml = {"xmlformatter"}}}}
