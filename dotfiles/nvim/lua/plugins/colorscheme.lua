return {
  {
    "Shatur/neovim-ayu",
    opts = {
      mirage = true,
      terminal = true,
      overrides = {},
    },
    config = function(_, opts)
      require("ayu").setup(opts)
    end,
  },
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
