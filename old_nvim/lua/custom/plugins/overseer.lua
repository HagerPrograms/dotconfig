return {
  'stevearc/overseer.nvim',
  dependencies = {
    -- optional but nice UX for prompts
    'stevearc/dressing.nvim',
    -- optional: Telescope picker for tasks
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local overseer = require 'overseer'

    overseer.setup {
      -- Pick up npm/yarn/pnpm scripts, make, cargo, etc.
      templates = { 'builtin', 'user' },
      -- Show tasks in a terminal split at the bottom by default
      strategy = {
        'terminal',
        use_shell = true,
        direction = 'horizontal',
        open_on_start = true,
        quit_on_exit = 'success',
      },
      -- optional quality-of-life defaults
      task_list = {
        direction = 'bottom',
        min_height = 15,
        max_height = 20,
        bindings = {
          ['q'] = function()
            vim.cmd 'OverseerClose'
          end,
        },
      },
    }

    -- (Optional) Telescope integration so you get a nice picker
    pcall(function()
      require('telescope').load_extension 'overseer'
    end)

    -- Keymaps (leader + o + …)
    local map = vim.keymap.set
    map('n', '<leader>or', '<cmd>OverseerRun<CR>', { desc = 'Overseer: Run…' })
    map('n', '<leader>oo', '<cmd>OverseerToggle<CR>', { desc = 'Overseer: Toggle task list' })
    map('n', '<leader>ol', '<cmd>OverseerRunCmd<CR>', { desc = 'Overseer: Run shell command' })
    map('n', '<leader>oa', '<cmd>OverseerQuickAction<CR>', { desc = 'Overseer: Quick action (restart/stop…)' })
    map('n', '<leader>olr', '<cmd>OverseerLoadBundle<CR>', { desc = 'Overseer: Load task bundle' })
    map('n', '<leader>os', '<cmd>Telescope overseer<CR>', { desc = 'Overseer: Telescope picker' })
  end,
}
