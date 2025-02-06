return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        {
            "williamboman/mason.nvim",
            lazy = false,
            config = true,
        }
    },
    opts = {
        ensure_installed = {
            'asm_lsp',
            'bashls',
            'biome',
            'cssls',
            'emmet_ls',
            'lemminx',
            'remark_ls',
            'taplo',
            'ts_ls',
            'zls',
        }
    },
}
