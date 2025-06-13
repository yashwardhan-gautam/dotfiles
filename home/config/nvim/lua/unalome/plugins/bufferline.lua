return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        -- Enable LSP diagnostics indicators
        diagnostics = "nvim_lsp",
        -- Add an offset for nvim-tree
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        -- Show buffer close icons
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
    })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>", { desc = "Close buffer" })
    keymap.set("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })
  end,
}