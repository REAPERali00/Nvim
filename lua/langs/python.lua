return {
  -- Setup adapters as nvim-dap dependencies
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
      },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },

  -- Add `python` debugger to mason DAP to auto-install
  -- Not absolutely necessary to declare adapter in `ensure_installed`, since `mason-nvim-dap`
  -- has `automatic-install = true` in LazyVim by default and it automatically installs adapters
  -- that are are set up (via dap) but not yet installed. Might as well skip the lines below as
  -- a whole.

  -- Add which-key namespace for Python debugging
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>dP", group = "Python" },
      },
    },
  },

  -- Setup `neotest`
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },

  -- For selecting virtual envs
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    cmd = "VenvSelect",
    opts = {
      dap_enabled = true,
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
}
