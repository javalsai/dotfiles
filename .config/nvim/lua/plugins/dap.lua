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

local function mk_debug()
  vim.ui.input({
    prompt = 'executable: ',
    default = vim.fn.getcwd() .. '/',
    completion = 'file',
  }, function(input_path)
    if input_path then
      local executable_path = input_path

      vim.ui.input({
        prompt = 'args: ',
      }, function(input_args)
        if input_args then
          local executable_args = utils.split(input_args)

          require 'dap'.configurations.cpp = {
            {
              type = 'lldb',
              request = 'launch',
              name = 'Launch Executable',
              program = executable_path,
              -- cwd = '${workspaceFolder}',
              stopOnEntry = false,
              args = executable_args,
            },
          }
        else
          vim.notify('No args given', vim.log.levels.ERROR)
        end
      end)
    else
      vim.notify('No executable given', vim.log.levels.ERROR)
    end
  end)
end
vim.api.nvim_create_user_command('MkDebug', mk_debug,
  {
    desc = 'Makes an LLDB dap debug target for the given executable and arguents',
  }
)

local dap_spec = {
  'mfussenegger/nvim-dap',
  dependencies = { neotest_spec },
  config = function()
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
    { '<leader>dt', function() require 'neotest'.run.run({ strategy = 'dap' }) end, desc = 'DAP nearest test'      },
    { '<leader>db', function() require 'dap'.toggle_breakpoint() end,               desc = 'DAP toggle breakpoint' },
    { '<leader>dc', function() require 'dap'.continue() end,                        desc = 'DAP continue'          },
    { '<leader>ds', function() require 'dap'.step_over() end,                       desc = 'DAP step over'         },
    { '<leader>dS', function() require 'dap'.step_into() end,                       desc = 'DAP step into'         },
    { '<leader>dr', function() require 'dap'.repl.open() end,                       desc = 'DAP open repl'         },
    { '<leader>da', function() require 'dap'.close() end,                           desc = 'DAP abort'             },
  },
}

return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'nvim-neotest/nvim-nio', dap_spec },
  keys = {
    { '<leader>duo', function() require 'dapui'.open() end,   desc = 'DAP UI open'   },
    { '<leader>duc', function() require 'dapui'.close() end,  desc = 'DAP UI close'  },
    { '<leader>dut', function() require 'dapui'.toggle() end, desc = 'DAP UI toggle' },
  },
  opts = {},
}
