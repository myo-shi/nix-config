-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = LazyVim.safe_keymap_set

map("t", "<C-\\>", "<C-\\><C-n>", { noremap = true })

if vim.g.vscode then
  -- VSCode Neovim
  local vscode = require("vscode")
  local set = vim.keymap.set
  local del = vim.keymap.del
  -- local opts = { noremap = true, silent = true }
  set({ "n" }, "<leader>a", function()
    vscode.action("editor.action.quickFix")
  end)
  set({ "n" }, "<leader>e", function()
    vscode.action("workbench.action.toggleSidebarVisibility")
  end)
  set({ "n" }, "gs", function()
    vscode.action("typescript.goToSourceDefinition")
  end)
  set({ "n" }, "gr", function()
    vscode.action("editor.action.goToReferences")
  end)
  del({ "n" }, "<S-h>")
  set({ "n" }, "<S-h>", function()
    vscode.action("workbench.action.previousEditor")
  end)
  del({ "n" }, "<S-l>")
  set({ "n" }, "<S-l>", function()
    vscode.action("workbench.action.nextEditor")
  end)
  set({ "n" }, "[e", function()
    vscode.action("editor.action.marker.next")
  end)
  set({ "n" }, "]e", function()
    vscode.action("editor.action.marker.prev")
  end)
  set({ "x", "i" }, "<C-d>", function()
    vscode.with_insert(function()
      vscode.action("editor.action.addSelectionToNextFindMatch")
    end)
  end)
  set({ "i" }, "<C-a>", function()
    vscode.action("editor.action.triggerSuggest")
  end)
  set({ "n" }, "<C-w>o", function()
    vscode.action("workbench.action.closeOtherEditors")
  end)
  set({ "n" }, "<C-w><S-o>", function()
    vscode.action("workbench.action.closeEditorsInOtherGroups")
  end)
  set({ "i", "s" }, "<Tab>", function(fallback)
    local copilot = require("copilot.suggestion")
    if copilot.is_visible() then
      copilot.accept()
    else
      fallback()
    end
  end)
end
-- Add any additional keymaps here
