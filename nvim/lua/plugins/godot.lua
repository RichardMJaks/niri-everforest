return {
    { "habamax/vim-godot" },
    { "skywind3000/asyncrun.vim" },
    { "teatek/gdscript-extended-lsp.nvim", opts = { view_type = "floating", picker = "telescope" } },
    {
        "nvim-neo-tree/neo-tree.nvim",
        ft = "gdscript",
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false, -- show hidden files
                    hide_gitignored = false, -- show gitignored files
                    never_show = { "server.pipe" }, -- exact name match
                    never_show_by_pattern = { "*.uid" }, -- glob pattern
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        opts = function()
            local dap = require("dap")
            dap.adapters.godot = { type = "server", host = "127.0.0.1", port = 6006 }
            dap.configurations.gdscript = {
                { type = "godot", request = "launch", name = "Launch scene", project = "${workspaceFolder}" },
            }
        end,
    },
    { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "gdscript" } } },
}
