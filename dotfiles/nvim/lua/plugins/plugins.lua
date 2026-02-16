return {
  { "lambdalisue/suda.vim" },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
  {
    "cajames/copy-reference.nvim",
    opts = {}, -- optional configuration
    keys = {
      { "<leader>yf", "<cmd>CopyReference file<cr>", mode = { "n", "v" }, desc = "Copy file path" },
      { "<leader>yr", "<cmd>CopyReference line<cr>", mode = { "n", "v" }, desc = "Copy file:line reference" },
    },
  },
  -- { "rhart92/codex.nvim", opts = {
  --   split = "vertical",
  -- } },
  -- {
  --   "ishiooon/codex.nvim",
  --   dependencies = { "folke/snacks.nvim" },
  --   config = true,
  --   keys = {
  --     { "<leader>acc", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
  --     { "<leader>acf", "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
  --     { "<leader>acs", "<cmd>CodexSend<cr>", mode = "v", desc = "Codex: Send selection" },
  --     {
  --       "<leader>acs",
  --       "<cmd>CodexTreeAdd<cr>",
  --       desc = "Codex: Add file",
  --       ft = { "neo-tree", "oil" },
  --     },
  --   },
  -- },
  -- {
  --   "pittcat/codex.nvim",
  --   config = function()
  --     require("codex").setup({
  --       terminal = { direction = "vertical", size = 0.40 },
  --     })
  --     vim.keymap.set("n", "<leader>aco", function()
  --       require("codex").open()
  --     end, { desc = "Codex: Open TUI" })
  --     vim.keymap.set("n", "<leader>act", function()
  --       require("codex").toggle()
  --     end, { desc = "Codex: Toggle terminal" })
  --     vim.keymap.set("n", "<leader>acp", ":CodexSendPath<CR>", { desc = "Codex: Send file path" })
  --     vim.keymap.set("v", "<leader>acs", ":'<,'>CodexSendSelection<CR>", { desc = "Codex: Send selection" })
  --     vim.keymap.set("v", "<leader>acr", ":'<,'>CodexSendReference<CR>", { desc = "Codex: Send reference" })
  --     vim.keymap.set("v", "<leader>acc", ":'<,'>CodexSendContent<CR>", { desc = "Codex: Send reference" })
  --   end,
  -- },
}
