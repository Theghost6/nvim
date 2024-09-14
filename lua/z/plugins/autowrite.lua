return {
  'NitroSniper/autowrite.nvim',
  tag = '0.1.0', -- locked to current release
  opts = {
    create_commands = true,
    verbose_info = true,
    undo_hack = true,
  },
  --config
  config = function()
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
      callback = function()
        vim.cmd('silent write')
      end,
    })
  end
}
