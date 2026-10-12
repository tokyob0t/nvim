local icons = require('icons')

return {
    'rahuliyer95/mason.nvim',
    branch = 'feat/1888/pnpm-installer',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    ---@type MasonSettings
    opts = {
        max_concurrent_installers = 5,
        npm = {
            use_pnpm = true,
        },
        ui = {
            border = 'solid',
            path = 'skip',
            check_outdated_packages_on_open = true,
            icons = {
                package_installed = icons.package.installed,
                package_pending = icons.package.pending,
                package_uninstalled = icons.package.uninstalled,
            },
        },
    },
}
