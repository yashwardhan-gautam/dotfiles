-- Disable Mason entirely - LSPs are managed by Nix packages
return {
  -- Disable mason.nvim (renamed from williamboman/mason.nvim)
  { "mason-org/mason.nvim", enabled = false },

  -- Disable mason-lspconfig.nvim (renamed from williamboman/mason-lspconfig.nvim)
  { "mason-org/mason-lspconfig.nvim", enabled = false },

  -- Disable mason-nvim-dap if using codelldb from Nix
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
}
