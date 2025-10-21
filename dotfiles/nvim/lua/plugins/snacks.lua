return {
  "snacks.nvim",
  opts = {
    dashboard = {
      enabled = not vim.g.vscode,
      -- dashboard configuration
      preset = {},
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          pane = 2,
          cmd = "LANG=C cat " .. vim.fn.stdpath("config") .. "/assets/header.txt",
          padding = 1,
          height = 30,
        },
      },
    },
  },
}
