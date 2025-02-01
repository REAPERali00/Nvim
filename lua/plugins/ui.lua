return {
  {
    "nvimdev/dashboard-nvim",
    enabled = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>j",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#363944",
          }
          return buffer
        end,
      })
    end,
  },
  -- LazyGit integration with Telescope
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "sqlite" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {

        "<leader>m",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          -- default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- custom mappings
          vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
        end,
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          relativenumber = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
          custom = {
            "node_modules/.*",
            "bin/.*",
          },
        },
        log = {
          enable = true,
          truncate = true,
          types = {
            diagnostics = true,
            git = true,
            profile = true,
            watcher = true,
          },
        },
      })

      if vim.fn.argc(-1) == 0 then
        vim.cmd("Neotree focus")
      end
    end,
  },
  -- documentation: https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        signs = { "󰫎 " },
        width = "block",
      },
      checkbox = {
        enabled = true,
        checked = { scope_highlight = "@markup.strikethrough" },
      },
      dash = {
        width = 50,
      },
      sign = {
        enabled = true,
        highlight = "RenderMarkdownSign",
      },
      bullet = {
        left_pad = 2,
        right_pad = 2,
      },
      latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
        top_pad = 0,
        bottom_pad = 0,
      },
      -- We can Customize check boxes this way
      -- checkbox = {
      --   enabled = true,
      --   unchecked = { icon = "✘ " },
      --   checked = { icon = "✔ " },
      --   custom = { todo = { rendered = "◯ " } },
      --
      -- },
    },
  },
}
