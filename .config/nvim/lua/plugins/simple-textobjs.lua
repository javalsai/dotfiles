-- reminders:
-- - subword is S
-- - argument is ,
-- - anybracket is o
-- - any quote is q
-- - key/value are k/v
-- - URLs are L
-- and more misc:
-- - emoji/glyph is .
-- - color in CSS is #
-- - [[...]] is D
-- - numbers are n
-- - nvim diagnostic refered text is !
-- - last change is ;

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
