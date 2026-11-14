if vim.g.vscode then
    return
end

require('startup-profile').install()

local installPlugin = require('utils.installPlugin')

installPlugin('hotpot', 'rktjmp/hotpot.nvim', 'main')

require('modules')
