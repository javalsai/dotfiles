local utils = require 'utils'

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
  config = function()
    require 'dap'.configurations.cpp = {
      {
        type = 'lldb',
        request = 'launch',
        name = 'Launch Executable',
        program = function()
          return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        -- cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          return utils.split(vim.fn.input('args: '))
        end,
      },
    }


    local lldb_dap = vim.fn.exepath('lldb-dap')
    if lldb_dap ~= '' then
      require 'dap'.adapters.lldb = {
        type = 'executable',
        command = lldb_dap,
        args = {},
      }
    end
  end,
  keys = {
    { '<leader>dt', function() require 'neotest'.run.run({ strategy = 'dap' }) end, desc = 'DAP nearest test' },
    { '<leader>db', function() require 'dap'.toggle_breakpoint() end,               desc = 'DAP toggle breakpoint' },
    { '<leader>dc', function() require 'dap'.continue() end,                        desc = 'DAP continue' },
    { '<leader>ds', function() require 'dap'.step_over() end,                       desc = 'DAP step over' },
    { '<leader>dS', function() require 'dap'.step_into() end,                       desc = 'DAP step into' },
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
