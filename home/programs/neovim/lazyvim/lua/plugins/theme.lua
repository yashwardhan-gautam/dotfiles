return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",
      palette_overrides = {
        -- Match Ghostty's gruvbox-dark palette exactly
        dark0_hard = "#1d2021",      -- Background
        dark0 = "#282828",           -- Slightly lighter background
        dark0_soft = "#32302f",      -- Softer background
        dark1 = "#3c3836",           -- Lighter background
        dark2 = "#504945",           -- Selection background
        dark3 = "#665c54",           -- Even lighter background
        dark4 = "#7c6f64",           -- Gray
        dark4_256 = "#7c6f64",       -- Gray for 256 colors
        
        gray_245 = "#928374",        -- Gray
        gray_244 = "#928374",        -- Gray
        
        light0_hard = "#f9f5d7",     -- Hard light
        light0 = "#fbf1c7",          -- Light
        light0_soft = "#f2e5bc",     -- Soft light
        light1 = "#ebdbb2",          -- Lighter
        light2 = "#d5c4a1",          -- Even lighter
        light3 = "#bdae93",          -- Light gray
        light4 = "#a89984",          -- Gray
        
        bright_red = "#fb4934",      -- Bright red
        bright_green = "#98971a",    -- Bright green
        bright_yellow = "#fabd2f",   -- Bright yellow
        bright_blue = "#83a598",     -- Bright blue
        bright_purple = "#d3869b",   -- Bright purple
        bright_aqua = "#8ec07c",     -- Bright aqua
        bright_orange = "#fe8019",   -- Bright orange
        
        neutral_red = "#cc241d",     -- Neutral red
        neutral_green = "#98971a",   -- Neutral green
        neutral_yellow = "#d79921",  -- Neutral yellow
        neutral_blue = "#458588",    -- Neutral blue
        neutral_purple = "#b16286",  -- Neutral purple
        neutral_aqua = "#689d6a",    -- Neutral aqua
        neutral_orange = "#d65d0e",  -- Neutral orange
        
        faded_red = "#9d0006",       -- Faded red
        faded_green = "#79740e",     -- Faded green
        faded_yellow = "#b57614",    -- Faded yellow
        faded_blue = "#076678",      -- Faded blue
        faded_purple = "#8f3f71",    -- Faded purple
        faded_aqua = "#427b58",      -- Faded aqua
        faded_orange = "#af3a03",    -- Faded orange
      },
    })
  end,
}