-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start Godot LSP & Configure to match GDScript syntax
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
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldlevelstart = 0
    end,
})

-- Don't list empty buffers in buffer list
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.schedule(function()
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_name(b) == "" and vim.bo[b].buftype == "" and not vim.bo[b].modified then
                    vim.bo[b].buflisted = false
                end
            end
        end)
    end,
})
-- Relist an unnamed buffer if it has modifications
-- Preceding autocmd removes it from buffer as soon as buffer is entered,
-- so this workaround is required
vim.api.nvim_create_autocmd("BufModifiedSet", {
    callback = function(args)
        local b = args.buf
        if vim.api.nvim_buf_get_name(b) == "" and vim.bo[b].buftype == "" and vim.bo[b].modified then
            vim.bo[b].buflisted = true
        end
    end,
})
