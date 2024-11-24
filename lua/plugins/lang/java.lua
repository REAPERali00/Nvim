return {
  "nvim-java/nvim-java",
  config = function()
    -- Ensure nvim-java is set up first
    require("java").setup({
      -- Your nvim-java configuration goes here
    })
  end,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            -- Your jdtls-specific configuration goes here
          },
        },
        setup = {
          jdtls = function(_, opts)
            -- Set up jdtls after java.nvim has been configured
            -- Ensure opts is passed correctly to the LSP setup
            require("lspconfig").jdtls.setup(opts)
            return true -- Return true to indicate that jdtls setup is handled
          end,
        },
      },
    },
  },
}
