return {
  -- 1. Install the theme plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensure it loads first
    opts = {
      -- custom options for the theme can go here
      flavour = "mocha", 
    }
  },

  -- 2. Configure LazyVim to load this colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
