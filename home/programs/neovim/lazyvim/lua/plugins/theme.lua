return {
  -- Gruvbox Dark theme - Retro groove color scheme for Vim
  -- https://github.com/morhetz/gruvbox
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    -- Set background to dark BEFORE setting up the theme
    vim.opt.background = "dark"
    
    require("gruvbox").setup({
      contrast = "hard",
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      dim_inactive = false,
      transparent_mode = false,
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("gruvbox")
  end,
}
