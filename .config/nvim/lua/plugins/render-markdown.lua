return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    require('plugins.treesitter'),
    {
      '3rd/image.nvim',
      opts = {
        integrations = {
          markdown = {
            only_render_image_at_cursor = true,
            only_render_image_at_cursor_mode = 'popup',
          },
        },
      },
    },
  },
  opts = {
    html = {
      comment = {
        conceal = false,
      },
    },
  },
}
