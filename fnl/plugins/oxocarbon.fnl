(local option vim.opt)
(local {: colorscheme} vim.cmd)

{1 :tokyob0t/oxocarbon.nvim
 :build false
 :init #(do
          (set option.background :dark)
          (colorscheme :oxocarbon))}
