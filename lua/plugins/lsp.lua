return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "csharpier",
        "netcoredbg",
        "csharp-language-server",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayhints = {
                includeinlayparameternamehints = "literal",
                includeinlayparameternamehintswhenargumentmatchesname = false,
                includeinlayfunctionparametertypehints = true,
                includeinlayvariabletypehints = false,
                includeinlaypropertydeclarationtypehints = true,
                includeinlayfunctionlikereturntypehints = true,
                includeinlayenummembervaluehints = true,
              },
            },
            javascript = {
              inlayhints = {
                includeinlayparameternamehints = "all",
                includeinlayparameternamehintswhenargumentmatchesname = false,
                includeinlayfunctionparametertypehints = true,
                includeinlayvariabletypehints = true,
                includeinlaypropertydeclarationtypehints = true,
                includeinlayfunctionlikereturntypehints = true,
                includeinlayenummembervaluehints = true,
              },
            },
          },
        },
        html = {},
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            lua = {
              workspace = {
                checkthirdparty = false,
              },
              completion = {
                workspaceword = true,
                callsnippet = "both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                settype = false,
                paramtype = true,
                paramname = "disable",
                semicolon = "disable",
                arrayindex = "disable",
              },
              doc = {
                privatename = { "^_" },
              },
              type = {
                castnumbertointeger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupseverity = {
                  strong = "warning",
                  strict = "warning",
                },
                groupfilestatus = {
                  ["ambiguity"] = "opened",
                  ["await"] = "opened",
                  ["codestyle"] = "none",
                  ["duplicate"] = "opened",
                  ["global"] = "opened",
                  ["luadoc"] = "opened",
                  ["redefined"] = "opened",
                  ["strict"] = "opened",
                  ["strong"] = "opened",
                  ["type-check"] = "opened",
                  ["unbalanced"] = "opened",
                  ["unused"] = "opened",
                },
                unusedlocalexclude = { "_*" },
              },
              format = {
                enable = false,
                defaultconfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "k" } } -- disable `k` as it conflicts with lsp hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_engine = "lualatex"
      vim.g.vimtex_enabled_file_types = { "tex", "md" }
    end,
    keys = {
      { "<localleader>l", "", desc = "+vimtext" },
    },
  },
}
