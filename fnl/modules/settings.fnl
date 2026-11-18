(import-macros {: let! : set!} :macros)

;; mason owns the LSP binaries but loads lazily now, so put them on PATH here
(let [bin (.. (vim.fn.stdpath :data) :/mason/bin)]
 (when (= 1 (vim.fn.isdirectory bin))
  (let! [env] PATH (.. bin ":" (. vim.env :PATH)))))

(set! updatetime 250)
(set! timeoutlen 400)

(set! conceallevel 2)
(set! infercase)
(set! shortmess+ :sWcI)
(set! signcolumn "yes:2")
(set! formatoptions [:q :j])
(set! termguicolors)
(set! nowrap)
(set! cursorline)
(set! statuscolumn "%C %s%l ")
(set! splitright)
(set! splitbelow)
(set! expandtab)
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)
(set! clipboard :unnamedplus)
(set! mouse :a)

(set! undofile)
(set! nowritebackup)
(set! noswapfile)

(set! ignorecase)
(set! smartcase)
(set! gdefault)
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")
(set! path ["." "**"])

(set! number)
(set! list)

(set! hidden)
(set! linebreak)
(set! breakindent)
(set! scrolloff 4)
(set! fillchars {:diff "╱" :eob " " :horiz " " :msgsep "─" :vert " "})

(set! listchars {:extends "»" :nbsp "␣" :precedes "«" :tab " ──" :trail "·"})
