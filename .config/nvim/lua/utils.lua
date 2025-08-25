--- @module 'which-key'

local M = {}

--- @class WkGroup
--- @field [1] string Assignment of the group mapping
--- @field group string Name of the group

--- @class LazyLikeSpec
--- @field [1] string
--- @field [2] string|function
--- @field mode string?|string[]
--- @field desc string?

--- @param wk wk
--- @param bufnr integer|boolean
--- @return fun(mode: string|string[], l: string, r: string|function, opts: vim.keymap.set.Opts?)
--- @return fun(spec: (LazyLikeSpec | WkGroup)[])
function M.bufmap(wk, bufnr)
  --- @param mode string|string[]
  --- @param l string
  --- @param r string|function
  --- @param opts vim.keymap.set.Opts?
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    opts.noremap = opts.noremap or true
    opts.silent = opts.silent or true
    vim.keymap.set(mode, l, r, opts)
  end

  return map, function(spec)
    for _, keymap in ipairs(spec) do
      if keymap.group then
        --- @cast keymap WkGroup
        wk.add(keymap)
      else
        --- @cast keymap LazyLikeSpec
        local opts = vim.tbl_deep_extend('force', {}, keymap)
        local kmap, fn = keymap[1], keymap[2]
        opts[1], opts[2] = nil, nil
        map(opts.mode or 'n', kmap, fn, opts)
      end
    end
  end
end

--- @param wk wk
--- @param mixed_kms (LazyKeysSpec|WkGroup)[]
--- @return LazyKeysSpec[]
function M.lazy_wkeys(wk, mixed_kms)
  --- @type LazyKeysSpec[]
  local keymaps = {}

  for _, keymap in ipairs(mixed_kms) do
    if keymap.group then
      --- @cast keymap WkGroup
      wk.add(keymap)
    else
      --- @cast keymap LazyKeysSpec
      table.insert(keymaps, keymap)
    end
  end

  return keymaps
end

--- @param pos1 integer[]
--- @param pos2 integer[]
--- @return integer[], integer[]
function M.sort_pos(pos1, pos2)
  if pos1[2] >= pos2[2] then
    if pos1[3] >= pos2[3] then
      if pos1[4] >= pos2[4] then
        return pos2, pos1
      end
    end
  end

  return pos1, pos2
end

--- @class KeyMap
--- @field [1] string lhs
--- @field [2] string|function rhs
--- @field [3]? string|string[] mode
--- @field desc? string Description

--- @param keymaps (KeyMap)[]
function M.keymaps_set(keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[3] or 'n', keymap[1], keymap[2], {
      desc = keymap.desc,
      noremap = true,
      silent = true,
    })
  end
end

return M
