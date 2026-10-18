return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- LUALINE
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "◗", right = "◖" },
            disabled_filetypes = {
                statusline = {},
                tabline = {},
                winbar = { "neo-tree" },
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
                refresh_time = 16, -- ~60fps
                events = {
                    "WinEnter",
                    "BufEnter",
                    "BufWritePost",
                    "SessionLoadPost",
                    "FileChangedShellPost",
                    "VimResized",
                    "Filetype",
                    "CursorMoved",
                    "CursorMovedI",
                    "ModeChanged",
                },
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "%S" },
            lualine_y = { "progress", "location", "fileformat" },
            lualine_z = {},
        },
        inactive_sections = {},
        tabline = {
            lualine_b = {
                {
                    "buffers",
                    disabled_buftypes = { "nofile" },
                    symbols = { alternate_file = "󰮲 ", modified = "🖋" },
                    buffers_color = {
                        active = "lualine_a_normal",
                    },
                },
            },
        },
        winbar = {
            lualine_a = {
                { "filename", padding = 1 },
            },
            lualine_y = {
                { "encoding", separator = "", padding = 1 },
                { "filetype", separator = "", padding = 0 },
                { "fileformat", separator = "", padding = 1 },
            },
        },
        inactive_winbar = {
            lualine_a = {
                { "filename", separator = { left = "", right = "" }, padding = 1 },
            },
        },
        extensions = { "neo-tree", "fugitive" },
    },
}
