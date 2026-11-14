if vim.g.vscode then
    return
end

require('utils.startupProfile').install()
require('utils.hotpotBoot').setup()

require('modules')
