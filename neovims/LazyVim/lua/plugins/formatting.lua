return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Run the import sorter, THEN the standard formatter
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
