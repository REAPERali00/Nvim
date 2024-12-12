return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- tag = "v0.9.1",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    opts = {
      highlight = { enabled = true },
      autopairs = { enabled = true },
      autotag = { enabled = true },
      indent = { enabled = true },

      ensure_installed = {
        "javascript",
        "typescript",
        "css",
        "html",
        "gitignore",
        "graphql",
        "http",
        "json",
        "scss",
        "sql",
        "vim",
        "lua",
        "python",
        "tsx",
        "bash",
        "cpp",
        "c_sharp",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}
