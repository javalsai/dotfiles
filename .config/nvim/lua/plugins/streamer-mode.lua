return {
    'Kolkhis/streamer-mode.nvim',
    config = function()
        require('streamer-mode').setup
        {
            -- use_defaults = false,

            -- paths = {
            --     '*',
            -- },

            keywords = {
                '\\(\'\\|"\\)*api_key\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*token\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*client_secret\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*powershell\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*$env:\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*userpassword\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*username\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*user.name\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*user.password\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*user.email\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*email\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*signingkey\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*IdentityFile\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
                '\\(\'\\|"\\)*credential.helper\\(\'\\|"\\)*\\s*\\(=\\|:\\)\\s*....',
            },

            exclude_all_default_keywords = true,

            level = 'edit',
            default_state = 'on',
            conceal_char = '…',
            -- patterns = {},
        }
    end
    -- opts = {
    --     default_state = 'on',
    --     level = 'edit',
    --     keywords = {
    --         'api_key',
    --         'token',
    --         'client_secret',
    --         'powershell',
    --         '$env:',
    --         'name',
    --         'userpassword',
    --         'username',
    --         'user.name',
    --         'user.password',
    --         'user.email',
    --         'email',
    --         'signingkey',
    --         'IdentityFile',
    --         'credential.helper',
    --         '!export',
    --         '!alias',
    --     },
    -- }
}
