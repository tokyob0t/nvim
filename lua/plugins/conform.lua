return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    init = function()
        vim.api.nvim_create_user_command('ToggleFormat', function()
            local global_state = vim.g.disable_autoformat
            local buffer_state = vim.b.disable_autoformat

            vim.b.disable_autoformat = not (global_state or buffer_state)
        end, {
            desc = 'Toggle autoformat-on-save',
        })
    end,
    opts = {
        formatters_by_ft = {
            c = { 'clang-format' },
            ['c++'] = { 'clang-format' },
            lua = { 'stylua' },
            fennel = { 'fnlfmt' },
            python = { 'isort', 'autoflake', 'yapf' },
            javascript = { 'biome' },
            toml = { 'taplo' },
            typescript = { 'biome' },
            -- tsx = { 'biome' },
            json = { 'biome' },
            sass = { 'prettierd' },
            scss = { 'prettierd' },
            nix = { 'nixpkgs-fmt', 'nixfmt' },
            sh = { 'beautysh' },
            sql = { 'sqlfmt', 'sleek' },
            go = {
                'gofumpt',
                'golines',
                'goimports',
                'goimports-reviser',
                'gomodifytags',
            },
        },
        format_after_save = function(bufnr)
            if vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 1000, lsp_format = 'fallback' }
        end,
    },
}
