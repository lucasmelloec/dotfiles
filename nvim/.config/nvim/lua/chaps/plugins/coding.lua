return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        opts = {},
      },
      'saadparwaiz1/cmp_luasnip',
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts_extend = { 'sources' },
    opts = function()
      -- Create highlight group to use with CmpGhostText
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          -- <C-e> will toggle between available choices in snip
          ['<C-e>'] = cmp.mapping(function()
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
      }
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'LazyFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search Project Todo/Fix/Warn/Note' },
      { '<leader>xt', '<cmd>TodoLocList<cr>', desc = 'Add Todo/Fix/Warn/Note to LocList' },
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'LazyFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
      { '<C-p>', desc = 'Increment Selection' },
      { '<C-p>', desc = 'Decrement Selection', mode = 'x' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },

    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts_extend = { 'ensure_installed', 'highlight.additional_vim_regex_highlighting', 'indent.disable' },
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = {},
      },
      indent = { enable = true, disable = {} },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-N>',
          node_incremental = '<C-N>',
          scope_incremental = false,
          node_decremental = '<C-p>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
            ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
            ['am'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
            ['im'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            ['ac'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter region' },
            ['ic'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter region' },
          },
        },
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']m'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']M'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[m'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[M'] = '@class.outer', ['[A'] = '@parameter.inner' },
        },
      },
    },
  },

  {
    'monaqa/dial.nvim',
    keys = {
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'normal')
        end,
        desc = 'Dial increment',
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'normal')
        end,
        desc = 'Dial decrement',
      },
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gnormal')
        end,
        desc = 'Dial special increment',
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gnormal')
        end,
        desc = 'Dial special decrement',
      },
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'visual')
        end,
        mode = 'v',
        desc = 'Dial increment (visual)',
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'visual')
        end,
        mode = 'v',
        desc = 'Dial decrement (visual)',
      },
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gvisual')
        end,
        desc = 'Dial special increment (visual)',
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gvisual')
        end,
        desc = 'Dial special decrement (visual)',
      },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          -- upper case boolean (like in Python)
          augend.constant.new {
            elements = { 'True', 'False' },
            word = true,
            cyclic = true,
          },
        },
      }
    end,
  },

  -- Git for the winners
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gedit', 'Gsplit', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'G' },
  },

  -- Cool things for ruby and case coercion
  {
    'tpope/vim-abolish',
    event = { 'LazyFile' },
  },

  -- Github
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    keys = {
      { '<leader>gpn', '<Cmd>Octo pr create<CR>', desc = 'Create a new PR' },
      { '<leader>gpl', '<Cmd>Octo pr list<CR>', desc = 'List PRs' },
      { '<leader>grn', '<Cmd>Octo review start<CR>', desc = 'Start reviewing PR' },
      { '<leader>grd', '<Cmd>Octo review submit<CR>', desc = 'Submit review' },
      { '<leader>grr', '<Cmd>Octo review resume<CR>', desc = 'Resume review' },
      { '<leader>grx', '<Cmd>Octo review discard<CR>', desc = 'Discard review' },
      { '<leader>grc', '<Cmd>Octo review close<CR>', desc = 'Close review' },
      { '<leader>gin', '<Cmd>Octo issue create<CR>', desc = 'Create a new issue' },
      { '<leader>gil', '<Cmd>Octo issue list<CR>', desc = 'List issues' },
      { '<leader>ga', '<Cmd>Octo actions<CR>', desc = 'List github actions' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'folke/which-key.nvim',
        optional = true,
        opts = {
          spec = {
            { '<leader>gp', group = 'Pull Request' },
            { '<leader>gr', group = 'Reviews' },
            { '<leader>gi', group = 'Issues' },
          },
        },
      },
    },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      github_hostname = vim.env.GH_HOST or '',
      use_localfs = true,
    },
  },

  -- allow some plugin actions to be dot repeated
  { 'tpope/vim-repeat', event = 'VeryLazy' },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = {
      linters_by_ft = {},
    },
    config = function(_, opts)
      local lint = require('lint')
      lint.linters_by_ft = opts.linters_by_ft

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },

  -- Illuminate same occurrence of words using LSP -> Treesiter -> Regex
  {
    'RRethy/vim-illuminate',
    event = { 'LazyFile' },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
