local function plural(str, bool)
    if bool then
        return str .. "s"
    else
        return str
    end
end

local function getWords()
    if vim.api.nvim_buf_get_offset(0, (vim.fn.getbufinfo(vim.fn.bufnr()))[1].linecount) > 1024 * 1024 then
        return ""
    end

    local wordcount = vim.fn.wordcount()

    local words = wordcount.words
    local text = " word"
    if wordcount.visual_words ~= nil then
        text = " selected" .. text
        words = wordcount.visual_words
    end

    return plural(tostring(words) .. text, words > 1)
end

return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = {
        extensions = { 'neo-tree', 'mason', 'lazy', 'fugitive' },
        sections = {
            lualine_c = { { 'filename', path = 1 }, 'selectioncount', 'searchcount' },
            lualine_x = { getWords }
        },
        inactive_sections = {
            lualine_c = { { 'filename', path = 1 } }
        },
    },
}
