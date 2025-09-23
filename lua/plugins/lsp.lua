return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        "mason-org/mason.nvim",
        opts = {
          opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
              "black",
              "ruff",
              "luacheck",
              "shellcheck",
              "shfmt",
              "tailwindcss-language-server",
              "typescript-language-server",
              "css-lsp",
              "csharpier",
              "netcoredbg",
              "csharp-language-server",
              "jdtls",
              "java-debug-adapter",
              "java-test",
              "cmakelang",
              "clangd",
              "codelldb",
            })
          end,
        },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        pylsp = {
          mason = false,
          settings = {
            pylsp = {
              plugins = {
                rope_autoimport = {
                  enabled = true,
                },
              },
            },
          },
        },
        ruff_lsp = {
          -- handlers = {
          --   ["textDocument/publishDiagnostics"] = function() end,
          -- },
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
        jdtls = {},
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        pyright = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "pyright" then
              -- disable hover in favor of jedi-language-server
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,

        jdtls = function(_, opts)
          require("lspconfig").jdtls.setup(opts)
          return true
        end,

        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,

        eslint = function()
          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  -- Setup up format with new `conform.nvim`
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { { "black", "ruff" } },
      },
    },
  },
}
