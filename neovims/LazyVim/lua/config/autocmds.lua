-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("clag_" .. name, { clear = true })
end

-- Disable comment creation after <CR> in Insert Mode or O/o in Normal Mode
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("comment_creation"),
--   desc = "Disable new comment creation after new line",
--   callback = function()
--     vim.opt.formatoptions:remove({ "c", "r", "o" })
--   end,
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Function to send Python code to tmux pane
function RunMarkdownPython()
  -- Get the current file path
  local file = vim.fn.expand("%:p")

  -- Ensure it's a Markdown file
  if not file:match("%.md$") then
    print("Not a Markdown file!")
    return
  end

  -- Extract Python code blocks
  local cmd = "sed -n '/```python/,/```/p' " .. file .. " | sed '1d;$d' > /tmp/md_script.py"
  os.execute(cmd)

  -- Send the extracted code to the tmux right pane
  os.execute("tmux send-keys -t right 'python3 /tmp/md_script.py' C-m")

  print("Executed Python code from Markdown!")
end

-- Create a Neovim command to call this function
vim.api.nvim_create_user_command("RunPy", RunMarkdownPython, {})

-- Optional: Map to a shortcut (e.g., <leader>r)
vim.api.nvim_set_keymap("n", "<leader>r", ":RunPy<CR>", { noremap = true, silent = true })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "help",
--   callback = function()
--     -- Map <CR> (Enter) to <C-]> (Jump to tag) only in help buffers
--     vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true, desc = "Follow Help Link" })
--
--     -- Optional: Map <BS> (Backspace) to <C-t> (Go back)
--     vim.keymap.set("n", "<BS>", "<C-t>", { buffer = true, desc = "Go Back" })
--   end,
-- })

-- Map '(' to behave exactly like '['
vim.keymap.set({ "n", "x", "o" }, "§", "[", { remap = true, desc = "Simulate [" })

-- Map ')' to behave exactly like ']'
vim.keymap.set({ "n", "x", "o" }, "à", "]", { remap = true, desc = "Simulate ]" })
