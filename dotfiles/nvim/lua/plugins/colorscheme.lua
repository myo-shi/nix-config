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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
