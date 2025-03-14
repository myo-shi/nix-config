-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- APIs
-- https://github.com/vscode-neovim/vscode-neovim?tab=readme-ov-file#%EF%B8%8F-api
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
  set({ "n", "x", "i" }, "<A-d>", function()
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
  -- undo/REDO via vscode
  -- https://github.com/vscode-neovim/vscode-neovim/issues/1139
  set("n", "u", function()
    vscode.call("undo")
  end)
  set("n", "<C-r>", function()
    vscode.call("redo")
  end)
  set("n", "<C-/>", function()
    vscode.call("workbench.action.terminal.toggleTerminal")
  end)
  set({ "n", "x" }, "<leader>r", function()
    vscode.with_insert(function()
      vscode.action("editor.action.refactor")
    end)
  end)
end
