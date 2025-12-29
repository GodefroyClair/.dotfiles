return {
  "folke/flash.nvim",
  opts = {
    modes = {
      search = {
        enabled = true, -- If set to true, flash will activate after you type /
      },
      -- This section controls f, F, t, T
      char = {
        enabled = true,
        multi_line = false,
        jump_labels = true,
        keys = { "f", "F", "t", "T", ";", "," },
        jump = {
          register = false,
          -- when using jump labels, set to 'true' to automatically jump
          -- or execute a motion when there is only one match
          autojump = true,
        },
      },
    },
  },
}
