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
        "latex",
        "markdown",
        "markdown_inline",
        "json",
        "scss",
        "sql",
        "vim",
        "lua",
        "python",
        "tsx",
        "bash",
        "c_sharp",
        "java",
        "c",
        "cpp",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}
