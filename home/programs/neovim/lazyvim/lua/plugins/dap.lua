return {
  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()

          -- Auto open/close UI when debugging starts/stops
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      -- GDB adapter
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      -- GDB configurations
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      -- Rust debugging handled by rustaceanvim with CodeLLDB

      -- Keymaps for DAP
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })

      -- DAP UI keymaps
      local dapui = require("dapui")
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap UI" })
      vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })
    end,
  },
}
