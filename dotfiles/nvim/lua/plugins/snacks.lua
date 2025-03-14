return {
  "snacks.nvim",
  opts = {
    dashboard = {
      enabled = not vim.g.vscode,
      -- dashboard configuration
      preset = {
        header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠛⢉⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢁⠼⠿⠿⢿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣁⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢋⣠⣤⣤⣶⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢡⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣭⣴⣾⣿⣿⣿⠿⢛⣋⣥
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣠⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣡⣾⣿⣿⣿⣿⠟⢋⣡⣶⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⣠⣿⣿⣿⣿⣿⣿⣿⣿⣫⣴⣿⣿⣿⡿⠟⢋⡁⣤⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣤⣶⣶⣾⣾⣿⢿⢿⠿⠟⢛⡛
⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⣤⣀⣦⣶⣶⣶⣶⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⢁⣾⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠘⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⠇⣼⣿⣽⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⢁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠻⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣟⠀⡿⠉⠉⡻⣿⣿⣿⣿⣿⠡⡀⠈⣧⢨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣄⠀⠒⠐⢓⡭⠭⣭⣻⣯⣀⣡⣤⡴⢚⣩⣴⠾⠿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡟⢠⣾⣷⢠⣿⣤⣀⣼⣿⣟⠿⢿⣿⣿⣯⣴⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⠏⣺⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣧⡄⠺⣻⣿⣦⣝⣯⡈⠉⢛⣭⣴⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⣸⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣤⣦⣌⠻⢿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠡⠰⢿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⢙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣥⣶⣶⣶⣶⣶⣶⣶⣶⣤⣭⣝⡛⢿⣿⣿
⣿⡇⢀⢥⣥⣍⠙⢿⣿⣿⣿⣿⡏⠀⣬⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡍⠿
⣷⠠⣽⣿⣧⣿⣿⣦⣬⣉⣩⣥⡔⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⡿⣿⣿⣿⣿⡿⠍⢠
⣿⣦⣙⢿⣿⣿⣿⣿⣿⣿⣿⡟⣰⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣄⠠⣴⣶⣶⣤⣬⡙⠛⠃⢠⣾
        ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
