return {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
        user_commands = false,
        lazy_load = true,
        options = {
            display = {
                mode = 'background',
                virtualtext = {
                    hl_mode = 'background',
                },
            },
        },
    },
}
