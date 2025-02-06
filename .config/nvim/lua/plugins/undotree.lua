return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', 'H', ':UndotreeToggle<CR>', { noremap = true, silent = true })
    end
}
