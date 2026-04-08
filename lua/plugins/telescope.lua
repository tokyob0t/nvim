return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
        defaults = {
            prompt_prefix = '   ',
            selection_caret = '  ',
            entry_prefix = '  ',
            sorting_strategy = 'ascending',
            layout_strategy = 'flex',
            set_env = { COLORTERM = 'truecolor' },
            dynamic_preview_title = 'layout_config',
            layout_config = {
                horizontal = { prompt_position = 'top', preview_width = 0.55 },
                vertical = { mirror = false },
                width = 0.87,
                height = 0.8,
                preview_cutoff = 120,
            },
        },
        pickers = { oldfiles = { prompt_title = 'Recent Files' } },
    },
    keys = {
        { '<leader>.', '<cmd>Telescope find_files<CR>' },
        { '<leader><Tab>.', '<cmd>Telescope oldfiles<CR>' },
        { '<leader>,', '<cmd>Telescope live_grep<CR>' },
        { '<leader><Tab>,', '<cmd>Telescope marks<CR>' },
        { '<leader>k', '<cmd>Telescope keymaps<CR>' },
    },
}
