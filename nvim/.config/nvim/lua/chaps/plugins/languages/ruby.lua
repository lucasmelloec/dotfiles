return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = {
      highlight = {
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { disable = { 'ruby' } },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
