if vim.g.vscode then
    return
end

local installPlugin = require('utils.installPlugin')

installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')

require('modules')
