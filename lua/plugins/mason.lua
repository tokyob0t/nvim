return {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
        local mason_compiler = require('mason-core.installer.compiler')
        local mason_result = require('mason-core.result')
        local npm_compiler =
            require('mason-core.installer.compiler.compilers.npm')

        -- Install npm packages with `pnpm`.
        local pnpm_npm = setmetatable({
            ---@async
            ---@param ctx InstallContext
            ---@param source ParsedNpmSource
            install = function(ctx, source)
                return mason_result.try(function(try)
                    -- Initialize a pnpm root, then scope the package name like the manager does.
                    try(ctx.spawn.pnpm({ 'init' }))
                    local package_json = try(
                        mason_result.pcall(
                            vim.json.decode,
                            ctx.fs:read_file('package.json')
                        )
                    )
                    package_json.name = '@mason/' .. package_json.name
                    package_json.devEngines = nil
                    package_json = try(
                        mason_result.pcall(vim.json.encode, package_json, {})
                    )
                    ctx.fs:write_file('package.json', package_json)
                    ctx.stdio_sink:stdout(
                        ('Installing npm package %s@%s with pnpm\n'):format(
                            source.package,
                            source.version
                        )
                    )
                    try(ctx.spawn.pnpm({
                        'add',
                        -- Flat layout so `node_modules/.bin/*` are symlinks mason can link to.
                        '--config.node-linker=hoisted',
                        ('%s@%s'):format(source.package, source.version),
                        source.extra_packages or vim.NIL,
                    }))
                end)
            end,
        }, { __index = npm_compiler })

        mason_compiler.register_compiler('npm', pnpm_npm)

        require('mason').setup({
            ui = {
                icons = {
                    package_installed = '●',
                    package_pending = '○',
                    package_uninstalled = '○',
                },
            },
        })
    end,
    opts = {
        ui = {
            icons = {
                package_installed = '●',
                package_pending = '○',
                package_uninstalled = '○',
            },
        },
    },
}
