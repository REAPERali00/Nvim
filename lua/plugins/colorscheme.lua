return {
  {
    { "rebelot/kanagawa.nvim" },
    {
      "NLKNguyen/papercolor-theme",
      lazy = false,
      priority = 1000,
      config = function()
        -- vim.go.background = "light"
        vim.g.PaperColor_Theme_Options = {
          theme = {
            ["default"] = {
              transparent_background = 1,
            },
            ["default.light"] = {
              transparent_background = 1,
            },
            ["default.dark"] = {
              transparent_background = 1,
            },
          },
        }
      end,
    },
    {
      "shaunsingh/nord.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = true
        vim.g.nord_uniform_diff_background = true
        vim.g.nod_bold = false
      end,
    },
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
      lazy = false,
      priority = 1000,
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
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.sonokai_transparent_background = "1"
        vim.g.sonokai_enable_italic = "1"
        vim.g.sonokai_style = "andromeda"
        -- vim.cmd.colorscheme("sonokai")
      end,
    },
    {
      "eldritch-theme/eldritch.nvim",
      lazy = false,
      name = "eldritch",
      opts = {
        -- This function is found in the documentation
        on_highlights = function(highlights)
          -- nvim-spectre highlight colors
          highlights.DiffChange = { bg = "#37f499", fg = "black" }
          highlights.DiffDelete = { bg = "#f265b5", fg = "black" }

          -- horizontal line that goes across where cursor is
          highlights.CursorLine = { bg = "#3f404f" }
          highlights.Comment = { fg = "#a5afc2" }

          -- I do the line below to change the color of bold text
          highlights["@markup.strong"] = { fg = "#f265b5", bold = true }

          -- Trying to change the spell underline color
          -- vim.cmd("highlight SpellBad cterm=undercurl gui=undercurl guisp=#37f499")
          -- highlights["@spell"] = { undercurl = true, sp = "#37f499" }
          -- highlights.SpellBad = { undercurl = true, sp = "#37f499" }
          highlights.SpellBad = { sp = "#37f499", undercurl = true }
          highlights.SpellCap = { sp = "#37f499", undercurl = true }
          highlights.SpellLocal = { sp = "#37f499", undercurl = true }
          highlights.SpellRare = { sp = "#37f499", undercurl = true }
        end,
      },
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
      lazy = false,
      priority = 1000,
      opts = {
        transparent_background = true,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin",
      },
    },
  },
}
