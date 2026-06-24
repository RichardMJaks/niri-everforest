-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start Godot LSP
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gdscript",
    callback = function()
        local root = vim.fs.dirname(vim.fs.find({ "project.godot" }, { upward = true })[1] or "")
        if root == "" or root == nil then
            return -- not a Godot project, don't attach
        end
        vim.lsp.start({
            name = "godot",
            cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
            root_dir = root,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gdscript",
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt.foldlevelstart = 0
    end,
})
