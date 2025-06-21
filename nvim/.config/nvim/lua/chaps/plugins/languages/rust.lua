return {
  -- Extend auto completion
  {
    'hrsh7th/nvim-cmp',
    optional = true,
    dependencies = {
      {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = {
      sources = { { name = 'crates' } },
    },
  },

  -- Add Rust & related to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = { ensure_installed = { 'rust', 'ron' } },
  },

  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>cR', function()
            vim.cmd.RustLsp('codeAction')
          end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp('debuggables')
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
              targetDir = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable('rust-analyzer') == 0 then
        error('**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/')
      end
    end,
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
      servers = {
        taplo = {
          keys = {
            {
              'K',
              function()
                if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
                  require('crates').show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = 'Show Crate Documentation',
            },
          },
        },
      },
      ensure_installed = {
        'codelldb',
        -- 'rust_analyzer',
      },
    },
  },

  {
    'nvim-neotest/neotest',
    optional = true,
    opts = {
      adapters = {
        ['rustaceanvim.neotest'] = {},
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
