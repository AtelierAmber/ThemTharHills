local rm = require("recipe-modify")
local tf = require("techfuncs")

local allowed_recipes = {
  mods["Krastorio2"] and "nitric-acid-early" or "nitric-acid",
  "gold-powder",
  "gold-plate",
  "trace-gold-from-copper",

  "gold-wire",
  "integrated-circuit",
  "transceiver",
  "advanced-cable",
  "hv-power-regulator",

  "molten-gold",

  "cheese-ore-processing"
}

--Get a reference to all prodmods to avoid doing these checks for each recipe
local prodmods = {}
for k, v in pairs(data.raw.module) do
  if v.effect and v.effect["productivity"] and v.limitation then
    table.insert(prodmods, v)
  end
end

for k, v in pairs(allowed_recipes) do
  if data.raw.recipe[v] then
    for j, i in pairs(prodmods) do
      table.insert(i.limitation, v)
    end
  end
end

local function removeProdmodAllowed(recipename)
  for k, v in pairs(prodmods) do
    for k2, v2 in pairs(v.limitation) do
      if v2 == recipename then
        v.limitation[k2] = nil
        break
      end
    end
  end
end

if mods["248k"] then
  if mods["space-exploration"] then
    removeProdmodAllowed("fu_gold_plate_recipe")
  else
    if mods["bzgold"] then
      removeProdmodAllowed("fu_gold_ingot_recipe")
      removeProdmodAllowed("fu_gold_plate_recipe")
    end
  end
  removeProdmodAllowed("gr_gold_wire_recipe")
end

for k, v in pairs(data.raw["map-gen-presets"]["default"]) do
  if type(v) == "table" and v.basic_settings and v.basic_settings.autoplace_controls and v.basic_settings.autoplace_controls["copper-ore"] then
    v.basic_settings.autoplace_controls["gold-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
    if mods["LunarLandings"] then
      v.basic_settings.autoplace_controls["cheese-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
    end
  end
end

if mods["LunarLandings"] then
  --LL hard-overrides the satellite recipe in DFF.
  rm.ReplaceIngredient("satellite", "advanced-circuit", "transceiver", 20, 20)
  if not mods["BrassTacks-Updated"] then
    tf.addRecipeUnlock("lunar-cheese-exploitation", "cheese-ore-processing-heat")
    data.raw.recipe["cheese-ore-processing-heat"].enabled = false
  end
end

require("deadlock")
require("compat.final")
