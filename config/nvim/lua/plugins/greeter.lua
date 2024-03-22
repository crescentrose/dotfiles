-- a lua powered greeter like vim-startify / dashboard-nvim
return {
  'goolord/alpha-nvim',
  config = function()
    require('alpha').setup(require('dashboard').config)
  end
}
