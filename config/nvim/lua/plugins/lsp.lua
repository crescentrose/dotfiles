-- Quickstart configs for Nvim LSP
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    { 'williamboman/mason.nvim', config = true },
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    'williamboman/mason-lspconfig.nvim',
    -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
    { 'j-hui/fidget.nvim',       opts = {} },
    -- 💻 Neovim setup for init.lua and plugin development with full signature help, docs and
    -- completion for the nvim lua API.
    'folke/neodev.nvim',
    -- nvim-cmp source for neovim builtin LSP client
    'hrsh7th/cmp-nvim-lsp',
  },
  event = "BufReadPost",
  config = function()
    require("lsp_support")
    SetupAutoCmd()

    -- List of LSP servers to install and support
    local servers = {
      gopls = {},
      pyright = {},
      rust_analyzer = {},
      tsserver = {},
      taplo = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },

      jsonls = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    local mason, lspconfig, neodev = require('mason'), require('mason-lspconfig'), require('neodev')
    mason.setup()
    neodev.setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
    lspconfig.setup_handlers({
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = capabilities,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end
    })
  end
}
