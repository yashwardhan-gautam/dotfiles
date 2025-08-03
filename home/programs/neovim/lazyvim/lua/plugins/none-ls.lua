return {
  "nvimtools/none-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(
        ".null-ls-root",
        ".neoconf.json",
        "Makefile",
        ".git"
      ),
      sources = {
        -- code actions
        -- formatters
        nls.builtins.formatting.alejandra,
        nls.builtins.formatting.black.with({
          extra_args = { "--line-length", "120" },
        }),
        nls.builtins.formatting.prettier.with({
          filetypes = {
            "css",
            "yaml.docker-compose",
            "yaml.kubernetes",
            "yaml",
          },
        }),
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.terraform_fmt,
        -- linters
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.diagnostics.hadolint,
      },
      on_attach = function(_, bufnr)
        -- Disable diagnostics for non-file buffers (like terminals)
        if vim.bo[bufnr].buftype ~= "" then
          vim.diagnostic.enable(false, bufnr)
        end
      end,
    }
  end,
}
