return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
    map("n", "<leader>fD", builtin.diagnostics, { desc = "Diagnostics" })
    map("n", "<leader>fw", builtin.grep_string, { desc = "Search current word" })
    map('n', '<leader>fb', builtin.buffers, { desc = 'Search buffers' })
    map('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
    -- Utilities
    map("n", "<leader>fr", builtin.resume, { desc = "Resume Search" })
  end,
}

