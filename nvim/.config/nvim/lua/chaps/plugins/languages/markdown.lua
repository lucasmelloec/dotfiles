return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.api.nvim_command('Lazy load markdown-preview.nvim')
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  },
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
      ensure_installed = { 'markdownlint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = {
      ensure_installed = { 'markdown', 'markdown_inline' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
