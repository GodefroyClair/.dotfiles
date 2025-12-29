return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    -- equivalent: url = "https://github.com/neovim/nvim-lspconfig.git",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}), -- clear by default
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("K", vim.lsp.buf.hover, "Get information about the element under cursoer", { 'n' })
          map("<leader>ca", vim.lsp.buf.code_action, "Propose some actions to solve an issue")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("gr", require("telescope.builtin").lsp_references, "Goto References")
          map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
          map("gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
          map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer Diagnostics")
          map("<leader>d", vim.diagnostic.open_float, "Line Diagnostics")

        end,
      })
    end,
  },
}
