-- https://gitea.com/duck-that-quacks/dotfiles/src/branch/main/config/nvim/snippets/all.lua

return {
  -- Blocks
  s({ trig = 'bbb', wordTrig = false }, { t({ '(', '\t' }), i(1), t({ '', ')' }), i(0) }),
  s({ trig = '[[b', wordTrig = false }, { t({ '[', '\t' }), i(1), t({ '', ']' }), i(0) }),
  s({ trig = 'BBb', wordTrig = false }, { t({ '{', '\t' }), i(1), t({ '', '}' }), i(0) }),
  s({ trig = 'aab', wordTrig = false }, { t({ '<', '\t' }), i(1), t({ '', '>' }), i(0) }),
  -- Pairs
  s({ trig = 'bb', wordTrig = false }, { t('('), i(1), t(')'), i(0) }),
  s({ trig = '[]', wordTrig = false }, { t('['), i(1), t(']'), i(0) }),
  s({ trig = 'BB', wordTrig = false }, { t('{'), i(1), t('}'), i(0) }),
  s({ trig = 'aa', wordTrig = false }, { t('<'), i(1), t('>'), i(0) }),
  s({ trig = 'qq', wordTrig = false }, { t("'"), i(1), t("'"), i(0) }),
  s({ trig = 'dd', wordTrig = false }, { t('\"'), i(1), t('\"'), i(0) }),
  s({ trig = 'cb', wordTrig = false }, { t('```'), i(1), t({ '', '```' }), i(0) }),
  -- Misc
  s({ trig = 'ca', wordTrig = false }, { t('('), i(1), t(');'), i(0) }),
}
