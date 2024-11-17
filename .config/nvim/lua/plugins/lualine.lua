return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = {
        sections = {
            lualine_c = { '%S' }
        }
    },
}
