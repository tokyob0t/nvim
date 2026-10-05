(local globals vim.g)
(local create-user-command vim.api.nvim_create_user_command)

{1 :stevearc/conform.nvim
 :cmd :ConformInfo
 :event :BufWritePre
 :init #(create-user-command :ToggleFormat
                             #(do
                                (local global-state globals.disable_autoformat)
                                (local buffer-state globals.disable_autoformat)
                                (set vim.b.disable_autoformat
                                     (not (or global-state buffer-state))))
                             {:desc "Toggle autoformat-on-save"})
 :opts {:format_after_save (fn [bufnr]
                             (when (. vim.b bufnr :disable_autoformat)
                               (lua "return "))
                             {:lsp_format :fallback :timeout_ms 1000})
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
                           :json [:biome]
                           :kdl [:kdlfmt]
                           :lua [:stylua]
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
