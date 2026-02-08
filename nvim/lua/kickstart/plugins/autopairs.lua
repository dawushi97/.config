-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency - updated for blink.cmp
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- Integration with blink.cmp
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      -- blink.cmp has built-in autopairs support, no additional setup needed
    end
  end,
}
