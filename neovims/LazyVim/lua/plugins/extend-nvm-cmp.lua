return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    -- We extend the existing mappings with our new "Super Enter"
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.mapping(function(fallback)
        -- PRIORITY 1: NES with Sidekick
        local sidekick = require("sidekick")
        if sidekick.nes_jump_or_apply() then
          return
        end

        -- PRIORITY 2: Check if the Completion Menu is open
        if cmp.visible() then
          -- Confirm the selection
          -- (uses the same logic as default LazyVim)
          local confirm_opts = { select = true } -- or use 'auto_select' if defined
          if cmp.confirm(confirm_opts) then
            return -- Stop here, Cmp handled it
          end
        end

        -- PRIORITY 3: Just a normal Enter key
        fallback()
      end, { "i", "s" }),
    })
  end,
}
