return {
  "github/copilot.vim",
  name = "copilot",
  config = function()
    vim.api.nvim_set_keymap('i', '<Tab>', 'copilot#Accept("<Tab>")', { expr = true, silent = true })
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_debug = false
    vim.keymap.set('i', '<C-N>', "<Plug>(copilot-next)")
    vim.keymap.set('i', '<C-D>', "<Plug>(copilot-dismiss)")
  end,
}
