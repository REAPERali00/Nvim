return {
  {
    { "rebelot/kanagawa.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "sainnhe/everforest" },
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
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = { transparent_background = true } },
    {
      "catppuccin",
      opts = {
        transparent_background = true,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "sonokai",
        transparent_background = true,
      },
    },
  },
}
