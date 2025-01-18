return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = {
        extensions = { 'neo-tree', 'mason', 'lazy', 'fugitive' },
        sections = {
            lualine_c = { { 'filename', path = 1 }, 'selectioncount', 'searchcount' }
        },
        inactive_sections = {
            lualine_c = { { 'filename', path = 1 } }
        },
    },
}
