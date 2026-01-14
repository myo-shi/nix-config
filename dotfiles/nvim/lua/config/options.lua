-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spelllang = { "en", "cjk" }

if vim.g.vscode then
  -- VSCode Neovim
  vim.opt.clipboard = { "unnamedplus" }
  local vscode = require("vscode")
  vim.notify = vscode.notify
end
