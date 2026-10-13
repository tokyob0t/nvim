local createCommand = require('utils.createCommand')

return {
    'dmtrKovalenko/fff',
    lazy = false,

    build = function()
        require('fff.download').download_or_build_binary()
    end,

    keys = {
        { '<leader>.', '<cmd>FFFindFiles<CR>' },
        { '<leader>,', '<cmd>FFFuzzySearch<CR>' },
    },

    init = function()
        local fff = require('fff')

        createCommand('FFFindFiles', 'Find Files', function()
            fff.find_files { title = 'Find Files' }
        end)

        createCommand('FFFuzzySearch', 'Fuzzy Search Files', function()
            fff.live_grep { title = 'Live Grep' }
        end)

        createCommand('FFFindOldFiles', 'Find Old Files', function()
            -- do something smart
        end)

        vim.api.nvim_set_hl(0, 'NormalTransparent', {
            fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).fg,
            bg = 'NONE',
        })
    end,

    opts = {
        prompt = '   ',
        title = 'Find Files',

        preview = {
            line_numbers = false,
            wrap_lines = false,
            cursorlineopt = 'both',
        },

        layout = {
            width = 0.87,
            height = 0.8,
            preview_size = 0.55,
            prompt_position = 'top',
            anchor = 'center',
            title_position = 'center',
            filename_position = 'center',
            show_path_first = true,
            show_scrollbar = true,
            show_file_count = false,
            border = 'solid',
        },

        git = {
            status_text_color = true,
            recency = {
                enabled = false,
            },
        },

        file_picker = {
            fuzzy_query_highlighting = true,
        },

        frecency = { enabled = false },
        suggestions = { enabled = false },
        logging = { enabled = false },
        grep = {
            location_format = '',
            trim_whitespace = true,
            modes = { 'plain', 'regex', 'fuzzy' },
        },

        history = {
            enabled = false,
        },

        hl = {
            title = 'TelescopePromptTitle',
            -- border = 'FFFFloatBorder',
            border = 'TelescopeBorder',
            normal = 'TelescopeNormal',
            matched = 'TelescopeMatching',

            winhl = {
                prompt = 'Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,FloatTitle:TelescopePromptTitle',
                preview = 'Normal:TelescopePreviewNormal,Title:TelescopePreviewTitle,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle',
                list = 'Normal:TelescopeNormal,FloatBorder:TelescopeResultsBorder,FloatTitle:TelescopeResultsTitle,CursorLine:TelescopeSelection',
                -- list = 'FloatBorder:Transparent,Border:Transparent',
            },

            prompt = 'TelescopePromptPrefix',
            cursor = 'TelescopeSelection',
            frecency = 'Number',
            debug = 'NormalTransparent',
            combo_header = 'NormalTransparent',
            scrollbar = 'TelescopeScrollbar',
            directory_path = 'NormalTransparent',

            selected = 'TelescopeSelection',
            selected_active = 'TelescopeSelection',

            git_staged = 'DiffAdded', -- Usa oxocarbon.base07 (verde/cyan de staged)
            git_modified = 'DiffChanged', -- Usa oxocarbon.base09 (naranja/amarillo de cambio)
            git_deleted = 'DiffRemoved', -- Usa oxocarbon.base10 (rojo/rosado de borrado)
            git_renamed = 'DiffChanged', -- Mismo color de modificación
            git_untracked = 'NonText', -- O puedes usar 'DiffAdded' si prefieres que destaque igual que staged
            git_ignored = 'Comment',

            --     -- Git signs
            git_sign_staged = 'GitSignsAdd',
            git_sign_modified = 'GitSignsChange',
            git_sign_deleted = 'GitSignsDelete',
            git_sign_renamed = 'GitSignsChange',
            git_sign_untracked = 'NonText',
            git_sign_ignored = 'Comment',

            -- Git signs selected
            git_sign_staged_selected = 'TelescopeSelection',
            git_sign_modified_selected = 'TelescopeSelection',
            git_sign_deleted_selected = 'TelescopeSelection',
            git_sign_renamed_selected = 'TelescopeSelection',
            git_sign_untracked_selected = 'TelescopeSelection',
            git_sign_ignored_selected = 'TelescopeSelection',

            --     -- Grep highlights
            grep_match = 'TelescopeMatching',
            grep_line_number = 'LineNr',
            grep_regex_active = 'DiagnosticInfo',
            grep_plain_active = 'Comment',
            grep_fuzzy_active = 'DiagnosticHint',

            --     -- Suggestions
            suggestion_header = 'WarningMsg',

            --     -- File info panel
            file_info_section = 'TelescopePreviewTitle',
            file_info_separator = 'TelescopeBorder',
            file_info_label = 'TelescopeResultsTitle',
            file_info_value = 'TelescopeNormal',
            file_info_value_dim = 'Comment',
            file_info_size = 'Number',
            file_info_type = 'Type',
            file_info_path = 'Directory',
            file_info_total_score = 'Bold',
            file_info_match_type = 'TelescopeMatching',
            file_info_score_pos = 'DiagnosticOk',
            file_info_score_neg = 'DiagnosticError',

            --     -- Per-window overrides ajustados según Telescope
        },
    },
}
