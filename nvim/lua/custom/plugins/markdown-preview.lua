return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = ':call mkdp#util#install()',
  init = function()
    vim.g.mkdp_auto_close = 1 -- 离开 markdown 时自动关闭预览
    vim.g.mkdp_theme = 'dark'
  end,
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', ft = 'markdown', desc = '[M]arkdown [P]review toggle' },
  },
}
