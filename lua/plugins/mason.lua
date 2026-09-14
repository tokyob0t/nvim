return {
    'rahuliyer95/mason.nvim',
    branch = 'feat/1888/pnpm-installer',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    opts = {
        max_concurrent_installers = 5,
        npm = {
            use_pnpm = true,
        },
        ui = {
            border = 'solid',
            PATH = 'SKIP',
            check_outdated_packages_on_open = true,
            icons = {
                package_installed = '●',
                package_pending = '○',
                package_uninstalled = '○',
            },
        },
    },
}
