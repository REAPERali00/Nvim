return {
  {
    { "rebelot/kanagawa.nvim" },
    {
      "craftzdog/solarized-osaka.nvim",
      lazy = true,
      priority = 1000,
      opts = function()
        return {
          transparent = true,

          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
        }
      end,
    },
    {
      "rose-pine/neovim",
      priority = 1000,
      config = function()
        require("rose-pine").setup({
          variant = "moon", -- auto, main, moon, or dawn
          dark_variant = "moon", -- main, moon, or dawn
          dim_inactive_windows = false,
          extend_background_behind_borders = true,

          enable = {
            terminal = true,
            legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
            migrations = true, -- Handle deprecated options automatically
          },

          styles = {
            bold = true,
            italic = true,
            transparency = true,
          },

          groups = {
            border = "muted",
            link = "iris",
            panel = "surface",

            error = "love",
            hint = "iris",
            info = "foam",
            note = "pine",
            todo = "rose",
            warn = "gold",

            git_add = "foam",
            git_change = "rose",
            git_delete = "love",
            git_dirty = "rose",
            git_ignore = "muted",
            git_merge = "iris",
            git_rename = "pine",
            git_stage = "iris",
            git_text = "rose",
            git_untracked = "subtle",

            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },

          highlight_groups = {
            -- Comment = { fg = "foam" },
            -- VertSplit = { fg = "muted", bg = "muted" },
            NormalFloat = { bg = "none" },
          },
        })
        -- vim.cmd("colorscheme rose-pine-main")
      end,
    },
    {
      "neanias/everforest-nvim",
      config = function()
        require("everforest").setup({
          transparent_background_level = 1,
        })
      end,
    },
    { "bluz71/vim-nightfly-colors" },
    { "NLKNguyen/papercolor-theme" },
    { "romainl/Apprentice" },
    {
      "sainnhe/sonokai",
      priority = 1000,
      config = function()
        vim.g.sonokai_transparent_background = "1"
        vim.g.sonokai_enable_italic = "1"
        vim.g.sonokai_style = "andromeda"
        -- vim.cmd.colorscheme("sonokai")
      end,
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      "catppuccin",
      opts = {
        transparent_background = true,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "tokyonight",
      },
    },
  },
}
