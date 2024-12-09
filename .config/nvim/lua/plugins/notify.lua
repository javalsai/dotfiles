return {
    'rcarriga/nvim-notify',
    config = function()
        require("notify").setup({
            background_colour = "#000000",
            timeout = 10000,
            fps = 48,
            render = "wrapped-default", -- compact",
            time_formats = {
                notification = "%T",
            },
            max_width = 70,
            stages = "slide"
        })
        vim.notify = require('notify')
    end
}
