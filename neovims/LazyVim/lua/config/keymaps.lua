local map = vim.keymap.set
-- Center line on screen when navigating with <C-d> or <C-u>
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll half a page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll half a page up" })

-- Markdown Previewer
map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Preview Markdown file" })
-- Hardtime Toggle
map("n", "<leader>H", "<cmd>Hardtime toggle<CR>", { desc = "Toggle Hardtime" })
-- Screenkey
map("n", "<leader>S", "<cmd>Screenkey<CR>", { desc = "Toggle Screenkey (Key casting)" })
-- Precognition
map("n", "<leader>p", '<cmd>lua require("precognition").toggle()<CR>', { desc = "Toggle Precognition" })
-- Git blame
map("n", "<leader>gB", "<cmd>BlameToggle virtual<CR>", { desc = "Toggle Git Blame view (virtual)" })

-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle Terminal with Ctrl + t (works in Normal and Terminal mode)
vim.keymap.set({ "n", "t" }, "<C-t>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })
