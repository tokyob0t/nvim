(import-macros {: command! : let! : custom-set-face!} :macros)

(local globals vim.g)

; vim.api.nvim_create_user_command("ToggleFormat", function()
;   local bufnr = vim.api.nvim_get_current_buf()

;   if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
;     -- Enable formatting
;     vim.b[bufnr].disable_autoformat = false
;     vim.g.disable_autoformat = false
;     print("Autoformat enabled")
;   else
;     -- Disable formatting
;     vim.g.disable_autoformat = true
;     print("Autoformat disabled")
;   end
; end, {
;   desc = "Toggle autoformat-on-save",
; })

{1 :stevearc/conform.nvim
 :cmd :ConformInfo
 :event :BufWritePre
 :init #(command! ToggleFormat
                  `(let! [b] disable-autoformat (not vim.b.disable-autoformat))
                  {:desc "Toggle autoformat-on-save for the current buffer"})
 :opts {:format_after_save (fn [bufnr]
                             (when (not (. vim.b bufnr :disable-autoformat))
                               {:lsp_format :fallback :timeout_ms 1000}))
        :formatters {:kdlfmt {:append_args [:--kdl-version :v1]}}
        :formatters_by_ft {:c [:clang-format]
                           :c++ [:clang-format]
                           :css [:prettierd]
                           :fennel [:fnlfmt]
                           :go [:gofumpt
                                :golines
                                :goimports
                                :goimports-reviser
                                :gomodifytags]
                           :html [:prettierd]
                           :javascript [:biome]
                           :astro [:biome]
                           :json [:biome]
                           :swift [:swiftformat]
                           :kdl [:kdlfmt]
                           :lua [:stylua]
                           :teal [:stylua]
                           :nix [:nixpkgs-fmt :nixfmt]
                           :python [:isort :autoflake :yapf]
                           :sass [:prettierd]
                           :scss [:prettierd]
                           :sh [:beautysh]
                           :sql [:sqlfmt :sleek]
                           :toml [:taplo]
                           :tsx [:biome]
                           :typescript [:biome]
                           :xml [:xmlformatter]}}}
