return {
  'R-nvim/R.nvim',
  opts = {
    R_args = { '--quiet', '--no-restore-data', '--no-save' },

    -- what in the INSANE defaults???
    --
    -- like whotf maps the leader in insert mode?? MY SPACES AREN'T SPACINGGGG
    disable_cmds = { 'RInsertPipe', 'RInsertAssign' },
  },
  lazy = false,
}
