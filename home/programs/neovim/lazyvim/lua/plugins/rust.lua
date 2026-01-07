return {
  -- Rustaceanvim - Enhanced Rust support
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    init = function()
      -- Configure rustaceanvim before it loads
      vim.g.rustaceanvim = {
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Keymaps for Rust files (with which-key descriptions)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- Rust-specific LSP commands
            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Runnables")
            map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
            map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, "Expand Macro")
            map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
            map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Parent Module")
            map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, "Join Lines")
            map("n", "<leader>rm", function() vim.cmd.RustLsp("rebuildProcMacros") end, "Rebuild Proc Macros")

            -- Code actions and hover
            map("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
            map("n", "<leader>rh", function() vim.cmd.RustLsp("hover", "actions") end, "Hover Actions")
            map("n", "<leader>rH", function() vim.cmd.RustLsp("hover", "range") end, "Hover Range")

            -- Diagnostics
            map("n", "<leader>rx", function() vim.cmd.RustLsp("explainError") end, "Explain Error")
            map("n", "<leader>rD", function() vim.cmd.RustLsp("renderDiagnostic") end, "Render Diagnostic")

            -- Testing
            map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, "Testables")

            -- Crate graph
            map("n", "<leader>rg", function() vim.cmd.RustLsp("crateGraph") end, "Crate Graph")

            -- Move items
            map("n", "<leader>rk", function() vim.cmd.RustLsp("moveItem", "up") end, "Move Item Up")
            map("n", "<leader>rJ", function() vim.cmd.RustLsp("moveItem", "down") end, "Move Item Down")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always",
                },
                reborrowHints = {
                  enable = "always",
                },
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim - Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)

      -- Crates.nvim keymaps (for Cargo.toml files)
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("n", "<leader>ct", crates.toggle, "Toggle Crates")
          map("n", "<leader>cr", crates.reload, "Reload Crates")

          map("n", "<leader>cv", crates.show_versions_popup, "Show Versions")
          map("n", "<leader>cf", crates.show_features_popup, "Show Features")
          map("n", "<leader>cd", crates.show_dependencies_popup, "Show Dependencies")

          map("n", "<leader>cu", crates.update_crate, "Update Crate")
          map("v", "<leader>cu", crates.update_crates, "Update Crates")
          map("n", "<leader>cU", crates.upgrade_crate, "Upgrade Crate")
          map("v", "<leader>cU", crates.upgrade_crates, "Upgrade Crates")
          map("n", "<leader>ca", crates.upgrade_all_crates, "Upgrade All")

          map("n", "<leader>cH", crates.open_homepage, "Open Homepage")
          map("n", "<leader>cR", crates.open_repository, "Open Repository")
          map("n", "<leader>cD", crates.open_documentation, "Open Docs")
          map("n", "<leader>cC", crates.open_crates_io, "Open crates.io")
        end,
      })
    end,
  },

  -- RustOwl - Visualize ownership and lifetimes
  {
    "cordx56/rustowl",
    version = "*",
    build = "cargo install rustowl",
    lazy = false,
    opts = {
      auto_enable = false, -- Manual toggle with <leader>ro
      idle_time = 500,
      highlight_style = "undercurl",
      client = {
        on_attach = function(_, buffer)
          vim.keymap.set("n", "<leader>ro", function()
            require("rustowl").toggle(buffer)
          end, { buffer = buffer, desc = "Toggle RustOwl" })
        end,
      },
    },
  },

  -- Which-key integration for Rust group
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>r", group = "Rust", icon = "🦀" },
        { "<leader>c", group = "Crates", icon = "📦" },
      },
    },
  },
}

