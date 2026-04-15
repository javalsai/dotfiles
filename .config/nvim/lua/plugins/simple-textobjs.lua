return {
  'chrisgrieser/nvim-various-textobjs',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      useDefaults = true,
      --- @type string[]
      disabledDefaults = { 'r', 'R' },
    },
  },
}
