return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- install automatically Mason tools
    },
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_pending = "➜",
            package_installed = "✓",
            package_uninstalled = "✗"
          }
        }
      })
      local tools_ensure_installed = {
        -- Formatters
        -- "black", -- Used to format python
        -- "isort", -- Used to format python
        -- "prettierd", -- Used to format a bunch of files (yaml, json, html, css, etc...)
        "stylua", -- Used to format Lua code
        -- Linters
        -- "eslint_d",
        "markdownlint",
        "marksman",
        "ruff",
        -- Static type checker
        "pyright",
      }
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Both",
              },
              diagnostics = {
                globals = { "vim" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
            }
          }
        },
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
              analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                autoImportCompletions = true,
                ignore = { "*" },
              },
            },
          },
        },
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local servers_ensure_installed = vim.tbl_keys(servers or {})
      require("mason-tool-installer").setup({ ensure_installed = tools_ensure_installed })
      require("mason-lspconfig").setup {
        ensure_installed = servers_ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end
  },
}
