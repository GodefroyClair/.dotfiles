-- Autocommands configuration file

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

local function send_python_code_to_tmux()
    -- Yank the current paragraph (assumes the Python code block is in a paragraph)
    -- Get the current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor_pos[1], cursor_pos[2]

    -- Find the start of the code block (```python)
    local start_line = vim.fn.search('^```python\\s*$', 'bnW')
    if start_line == 0 then
        vim.notify("No Python code block found!", vim.log.levels.ERROR)
        return
    end

    -- Find the end of the code block (```)
    local end_line = vim.fn.search('^```\\s*$', 'nW')
    if end_line == 0 then
        vim.notify("No end of code block found!", vim.log.levels.ERROR)
        return
    end

    -- Extract the lines of the code block (excluding delimiters)
    local code_lines = vim.api.nvim_buf_get_lines(0, start_line, end_line - 1, false)
    local code = table.concat(code_lines, "\n")

    -- Execute the Python code and capture the output
    local output = vim.fn.system('python3 -c "' .. code:gsub('"', '\\"') .. '"')

    -- Write the output to a temporary file
    local tmp_file = os.tmpname()
    local file = io.open(tmp_file, "w")
    if file then
        file:write(output)
        file:close()
    else
        vim.notify("Failed to create temporary file!", vim.log.levels.ERROR)
        return
    end

      -- Clear the second tmux window
    vim.fn.system('tmux send-keys -t 1 "clear" C-m')

    -- Send only the output to the second tmux window for display
    local tmux_command = string.format('tmux send-keys -t 1 "cat %s" C-m', tmp_file)
    vim.fn.system(tmux_command)


      -- Clean up the temporary file
    vim.fn.system('rm ' .. tmp_file)

end
vim.api.nvim_create_user_command("RunPyinCur", send_python_code_to_tmux, {})

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
vim.api.nvim_set_keymap('n', '<leader>r', ':RunPy<CR>', { noremap = true, silent = true })

