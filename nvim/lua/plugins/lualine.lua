local function hl(name, attr)
    local h = vim.api.nvim_get_hl(0, { name = name, link = false })
    return h[attr] and string.format("#%06x", h[attr]) or nil
end

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
            lualine_y = { "progress", "location" },
            lualine_z = { "fileformat" },
        },
        inactive_sections = {},
        tabline = {
            lualine_b = {
                { "buffers", disabled_buftypes = { "nofile", "" }, symbols = { alternate_file = "󰮲 " } },
            },
        },
        winbar = {
            lualine_a = {
                { "filename", separator = { left = "", right = "" }, padding = 1 },
            },
            lualine_x = {
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
