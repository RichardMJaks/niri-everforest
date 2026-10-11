return {
    { "habamax/vim-godot" },
    { "skywind3000/asyncrun.vim" },
    { "teatek/gdscript-extended-lsp.nvim", opts = { view_type = "floating", picker = "snacks" } },
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                sources = {
                    explorer = {
                        hidden = true, -- show hidden files
                        ignored = false, -- don't show gitignored files
                        exclude = { -- exclude specific patterns
                            "*.uid", -- glob pattern for files ending with .uid
                            "server.pipe", -- exact filename match
                        },
                    },
                },
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
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
}
