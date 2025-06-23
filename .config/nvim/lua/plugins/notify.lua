return {
    'javalsai/nvim-notify-patch',
    config = function()
        -- local hostname_proc = assert(io.popen('hostname'))
        -- local output = hostname_proc:read('*all')
        -- hostname_proc:close()
        -- if output ~= 'artway' then
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
        -- end
    end
}
