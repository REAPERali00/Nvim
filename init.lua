-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.options")
require("config.keymaps")
require("config.lazy")
require("nvim-treesitter.install").prefer_git = true
