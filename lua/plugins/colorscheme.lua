return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme("sonokai")
    end,
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    { -- plugin spec for catppuccin
      "catppuccin/nvim",
    },
    -- this belongs to no plugin spec and is ignored
    lazy = false,
    name = "catppuccin",
    opts = {
      transparent_background = true,
    },

    { -- plugin spec for LazyVim
      "LazyVim/LazyVim",
    },
  },
}
