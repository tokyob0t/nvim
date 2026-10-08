-- [nfnl] fnl/plugins/mason.fnl
local function _1_()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  mason.setup({ui = {border = "solid", width = 0.8, height = 0.9, title_pos = "center", icons = {package_installed = "\226\156\147", package_pending = "\226\158\156", package_uninstalled = "\226\156\151"}}})
  return mason_lspconfig.setup({ensure_installed = {"lua_ls", "ts_ls", "rust_analyzer", "fennel_language_server"}, automatic_enable = true})
end
return {[{1}] = "williamboman/mason.nvim", cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog"}, dependencies = {{[{1}] = "williamboman/mason-lspconfig.nvim"}, {[{1}] = "neovim/nvim-lspconfig"}}, config = _1_}
