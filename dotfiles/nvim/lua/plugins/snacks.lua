return {
  "snacks.nvim",
  opts = {
    ---@class snacks.dashboard.Config
    dashboard = {
      enabled = not vim.g.vscode,
      -- dashboard configuration
      preset = {
        header = [[]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", padding = 1 },
        {
          enabled = function()
            return vim.o.lines > 40 or vim.o.columns > 120
          end,
          section = "terminal",
          pane = 2,
          cmd = "LANG=C cat " .. vim.fn.stdpath("config") .. "/assets/header.txt",
          height = 20,
          indent = 5,
        },
      },
    },
  },
}
