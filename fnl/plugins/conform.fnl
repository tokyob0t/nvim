(import-macros {: command! : plugin! : let!} :macros)

(plugin! :stevearc/conform.nvim
 {:cmd :ConformInfo
  :event :BufWritePre
  :init (fn []
         (command! ToggleFormat `(let! [b] disable-autoformat (not vim.b.disable-autoformat))
          {:desc "Toggle autoformat-on-save for the current buffer"}))
  :opts {:format_after_save (fn [bufnr]
                             (when (not (. vim.b bufnr :disable-autoformat))
                              {:lsp_format :fallback :timeout_ms 1000 :async true}))
         :formatters {:kdlfmt {:append_args [:--kdl-version :v1]} :fennelfmt {:command :fennelfmt :args [:-]}}
         :formatters_by_ft {:c [:clang-format]
                            :c++ [:clang-format]
                            :css [:prettierd]
                            :rust [:rustfmt]
                            :fennel [:fennelfmt]
                            :clojure [:cljfmt]
                            :go [:gofumpt :golines :goimports :goimports-reviser :gomodifytags]
                            :html [:prettierd]
                            :javascript [:biome]
                            :astro [:biome]
                            :json [:biome]
                            :swift [:swiftformat]
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
                            :xml [:xmlformatter]}}})
