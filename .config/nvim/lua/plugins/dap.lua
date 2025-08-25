local neotest_spec = {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    require 'plugins.treesitter',
    require 'plugins.lspconfig',
  },
  opts = function()
    return {
      adapters = {
        require 'rustaceanvim.neotest',
      },
    }
  end,
  config = true,
}

local dap_spec = {
  'mfussenegger/nvim-dap',
  dependencies = { neotest_spec },
  keys = {
    { '<leader>dt', function() require 'neotest'.run.run({ strategy = 'dap' }) end, desc = 'DAP nearest test' },
    { '<leader>db', function() require 'dap'.toggle_breakpoint() end,               desc = 'DAP toggle breakpoint' },
    { '<leader>dc', function() require 'dap'.continue() end,                        desc = 'DAP continue' },
    { '<leader>ds', function() require 'dap'.step_over() end,                       desc = 'DAP step over' },
    { '<leader>dr', function() require 'dap'.repl.open() end,                       desc = 'DAP open repl' },
    { '<leader>da', function() require 'dap'.close() end,                           desc = 'DAP abort' },
  },
}

return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'nvim-neotest/nvim-nio', dap_spec },
  keys = {
    { '<leader>duo', function() require 'dapui'.open() end,   desc = 'DAP UI open' },
    { '<leader>duc', function() require 'dapui'.close() end,  desc = 'DAP UI close' },
    { '<leader>dut', function() require 'dapui'.toggle() end, desc = 'DAP UI toggle' },
  },
  opts = {},
}
