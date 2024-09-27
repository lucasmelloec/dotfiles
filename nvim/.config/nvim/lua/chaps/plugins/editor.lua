return {
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    event = 'LazyFile',
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'LazyFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
      plugins = { spelling = true },
      icons = {
        mappings = true,
        keys = {},
      },
      spec = {
        { '<leader>b', group = 'Buffer' },
        { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
        { '<leader>x', group = 'Diagnostics' },
        { '<leader>g', group = 'Git' },
        { '<leader>gh', group = 'Git Hunk', mode = { 'n', 'v' } },
        { '<leader>s', group = 'Search' },
        { '<leader><tab>', group = 'Tab' },
        { '<leader>u', group = 'UI' },
        { '<leader>w', group = 'Window' },
        { 'gz', group = 'Surround' },
        { ']', group = 'Next' },
        { '[', group = 'Prev' },
      },
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        enabled = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', optional = true },

      -- Search through luasnip snippets
      { 'benfowler/telescope-luasnip.nvim' },
    },
    keys = {
      {
        '<leader>sh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'Search Help',
      },
      {
        '<leader>sk',
        function()
          require('telescope.builtin').keymaps()
        end,
        desc = 'Search Keymaps',
      },
      {
        '<leader><leader>',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Search Files',
      },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'Search current Word',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Search by Grep',
      },
      {
        '<leader>sd',
        function()
          require('telescope.builtin').diagnostics()
        end,
        desc = 'Search Diagnostics',
      },
      {
        '<leader>sp',
        function()
          require('telescope.builtin').resume()
        end,
        desc = 'Search Resume',
      },
      {
        '<leader>s.',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = 'Search Recent Files ("." for repeat)',
      },
      {
        '<leader>sb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Find existing buffers',
      },
      { '<leader>sn', '<cmd>telescope luasnip<cr>', desc = 'Search Snippets' },
      -- Slightly advanced example of overriding default behavior and theme
      {
        '<leader>sg',
        function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = 'Search in current buffer',
      },
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.require('telescope.builtin').live_grep()` for information about particular keys
      {
        '<leader>s/',
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        desc = 'Search in Open Files',
      },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'luasnip')
    end,
  },

  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        neotest = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme('catppuccin-macchiato')

      -- You can configure highlights by doing something like:
      vim.cmd.hi('Comment gui=none')
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    opts = {
      ai = {
        n_lines = 500,
      },
      surround = {
        mappings = {
          add = 'gza', -- Add surrounding in Normal and Visual modes
          delete = 'gzd', -- Delete surrounding
          find = 'gzf', -- Find surrounding (to the right)
          find_left = 'gzF', -- Find surrounding (to the left)
          highlight = 'gzh', -- Highlight surrounding
          replace = 'gzr', -- Replace surrounding
          update_n_lines = 'gzn', -- Update `n_lines`
        },
      },
      statusline = {
        use_icons = true,
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts.ai)

      require('mini.surround').setup(opts.surround)

      local statusline = require('mini.statusline')
      statusline.setup(opts.statusline)

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.files').setup()
      vim.keymap.set('n', '-', function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end, { desc = 'Open Explorer Tree' })

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>bd', function()
        require('mini.bufremove').delete(0, false)
      end, { desc = 'Delete Buffer' })
      vim.keymap.set('n', '<leader>bD', function()
        require('mini.bufremove').delete(0, true)
      end, { desc = 'Delete Buffer (force)' })

      require('mini.icons').setup()
    end,
  },

  -- tmux navigation and register sync
  {
    'aserowy/tmux.nvim',
    keys = {
      { '<C-h>' },
      { '<C-j>' },
      { '<C-k>' },
      { '<C-l>' },
      {
        '<C-Left>',
        function()
          require('tmux').resize_left()
        end,
      },
      {
        '<C-Down>',
        function()
          require('tmux').resize_down()
        end,
      },
      {
        '<C-Up>',
        function()
          require('tmux').resize_up()
        end,
      },
      {
        '<C-Right>',
        function()
          require('tmux').resize_right()
        end,
      },
    },
    opts = function()
      local _opts = vim.deepcopy(require('tmux.configuration.options'), true)
      _opts.set = nil
      return vim.tbl_deep_extend('force', _opts, {
        copy_sync = {
          enable = true,
          sync_clipboard = false,
        },
        navigation = {
          enable_default_keybindings = true,
          cycle_navigation = false,
        },
        resize = {
          enable_default_keybindings = false,
          resize_step_x = 2,
          resize_step_y = 2,
        },
      })
    end,
  },

  -- search/replace in multiple files
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    -- stylua: ignore
    keys = {
      { "<leader>sR", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'folke/which-key.nvim',
        optional = true,
        opts = {
          spec = {
            { '<leader>h', group = 'Harpoon' },
          },
        },
      },
    },
    opts = {},
    keys = {
      {
        '<leader>hh',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon current buffer',
      },
      {
        '<leader>he',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'List of buffers',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Goto Harpoon Buffer 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Goto Harpoon Buffer 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Goto Harpoon Buffer 3',
      },
    },
  },

  {
    'mbbill/undotree',
    keys = {
      { '<leader>U', vim.cmd.UndotreeToggle, desc = 'Undo Tree' },
    },
  },

  -- indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'LazyFile' },
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'lazy',
          'mason',
          'notify',
        },
      },
    },
  },

  -- Disable certain features if file is too big
  { 'LunarVim/bigfile.nvim', event = 'VimEnter', opts = {} },

  -- Use gx to open links, files and plugins by name
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    opts = {},
  },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          jump_labels = true,
          jump = { autojump = true },
        },
      },
    },
    keys = {
      {
        'S',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
