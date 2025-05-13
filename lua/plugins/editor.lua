return {
  -- Hihglight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "vuciv/golf",
  },
  {
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    priority = 1000,
    keys = {
      {
        ";f",
        function()
          require("fzf-lua").files({ hidden = false, fd_opts = " -t f " })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "\\",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";;",
        function()
          require("fzf-lua").resume()
        end,
        desc = "Resume the previous fzf-lua picker",
      },
      {
        ";e",
        function()
          require("fzf-lua").diagnostics_workspace()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        ";s",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Lists Function names, variables, from LSP",
      },
      {
        "sf",
        function()
          require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h"), hidden = true })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.85,
          width = 0.85,
          preview = {
            default = "bat",
            border = "border",
            wrap = "wrap",
          },
        },
        fzf_opts = {
          ["--layout"] = "reverse",
          ["--info"] = "inline",
        },
      })
    end,
  },
}
