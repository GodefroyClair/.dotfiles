local M = {}

-- On définit une configuration par défaut
-- L'utilisateur pourra la surcharger s'il le souhaite
local default_config = {
  -- Si true, applique les mappings en mode Insert (pour taper le code)
  enable_insert = true,
  -- Si true, applique les mappings en mode Normal (pour les commandes vim comme 'dd' ou ']')
  enable_normal = true,
}

function M.setup(user_config)
  -- Fusionner la config utilisateur avec la config par défaut
  user_config = user_config or {}
  for k, v in pairs(user_config) do
    default_config[k] = v
  end

  -- Helper 1 : Pour les traductions de touches pures (nécessite remap = true)
  local function translate_key(modes, lhs, rhs, desc)
    vim.keymap.set(modes, lhs, rhs, {
      remap = true, -- CRUCIAL : Permet d'enchaîner avec les raccourcis LazyVim
      silent = true,
      desc = "AzertyFix: " .. desc,
    })
  end

  -- Helper 2 : Pour les raccourcis classiques (noremap = true)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      desc = "AzertyFix: " .. desc,
    })
  end

  ---------------------------------------------------------
  -- 1. MODE NORMAL & VISUAL (Pour la navigation)
  ---------------------------------------------------------
  if default_config.enable_normal then
    translate_key({ "n", "x", "o" }, "§", "[", "Translate é to [")
    translate_key({ "n", "x", "o" }, "à", "]", "Translate double-quote to ]")

    map("n", "ù", "\\", "Remap ù to backslash")
  end

  ---------------------------------------------------------
  -- 2. MODE INSERT (Pour écrire du code)
  ---------------------------------------------------------
  if default_config.enable_insert then
    map("i", "<A-(>", "[", "Insert [")
    map("i", "<A-)>", "]", "Insert ]")

    map("i", "<A-'>", "{", "Insert {")
    map("i", "<A-=>", "}", "Insert }")

    map("i", "ù", "\\", "Insert backslash")
  end
end

return M
