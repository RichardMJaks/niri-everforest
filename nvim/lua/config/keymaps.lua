-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>e", function()
    require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle NeoTree" })

vim.keymap.set({ "n", "x" }, "<leader>rs", function()
    -- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
    require("refactoring").select_refactor()
end, { desc = "Select refactor" })
