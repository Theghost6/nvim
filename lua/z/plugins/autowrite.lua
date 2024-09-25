return {
  'NitroSniper/autowrite.nvim',
  tag = '0.1.0', 
  opts = {
    create_commands = true,
    verbose_info = true,
    undo_hack = true,
  },
  config = function()
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
      callback = function()
        if vim.fn.expand('%') ~= '' then
          vim.cmd('silent! write')  
        end
      end,
    })
  end
}
 
