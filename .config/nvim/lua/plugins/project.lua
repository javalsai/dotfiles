return {
  'DrKJeff16/project.nvim',
  enabled = false,
  config = function()
    require('project').setup {
      detection_methods = { 'lsp', 'pattern' },
      patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        'init.lua',
      },
      silent_chdir = true,
    }
  end,
}
