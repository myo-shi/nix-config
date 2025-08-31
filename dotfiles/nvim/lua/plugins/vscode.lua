if not vim.g.vscode then
  return {}
end

return {}

-- local ok, snacks = pcall(require, "snacks")
-- if ok then
--   ---@class snacks.termial: snacks.win
--   function snacks.terminal()
--     require("vscode").action("workbench.action.terminal.toggleTerminal")
--   end
-- end
--
-- return {
--   {
--     "vscode-neovim/vscode-multi-cursor.nvim",
--     event = "VeryLazy",
--     cond = not not vim.g.vscode,
--     vscode = true,
--     opts = {},
--   },
-- }
