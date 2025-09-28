local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

--[[
local function nukeItem(itemname)
  data.raw.item[itemname] = nil
  --delete 248k duplication recipe
  data.raw.recipe["gr_white_hole_cycle_"..itemname.."_recipe"] = nil
  --delete voiding recipes
  --if you make a dynamic voiding mod with expensive variants i will eat your eyeballs
  for recname, recipe in pairs(data.raw.recipe) do
    if recipe.results and #recipe.results == 0 then
      if rm.CheckIngredient(recname, itemname) then
        data.raw.recipe[recname] = nil
      end
    end
  end
end
]]--

if mods["248k"] then
  rm.RemoveIngredient("processing-unit", "fi_materials_gold", 99999, 99999)
  rm.RemoveIngredient("processing-unit", "fi_materials_gold", 99999, 99999)
  --rm.ReplaceProportional("gr_circuit_recipe", "gr_materials_gold_wire", "gold-wire", 1)
  --rm.ReplaceProportional("gr_plasma_cube_recipe", "fi_materials_gold", "gold-plate", 1)

  --this conserves acid instead of gold
  if mods["bzgold"] then
    rm.AddIngredient("fi_pure_gold_recipe", "gold-ore", 2)
  else
    rm.AddIngredient("fi_pure_gold_recipe", "gold-ore", 6)
  end

  --data.raw.recipe["fi_cast_gold_recipe"].results = {{type="item", name="gold-plate", amount=1}}
  --data.raw.recipe["fi_cast_gold_recipe"].main_product = "gold-plate"
  --data.raw.recipe["gr_gold_wire_recipe"] = nil
  tf.removeRecipeUnlock("gr_circuit_tech", "gr_gold_wire_recipe")

  --nukeItem("fi_materials_gold")
  --nukeItem("gr_materials_gold_wire")

  --data.raw.recipe["kr-vc-fi_materials_gold"] = nil
  --data.raw.recipe["kr-vc-gr_materials_gold_wire"] = nil

  if mods["space-exploration"] then
    data.raw.recipe["fu_gold_ingot_recipe"].results = {{type="item", name="fu_materials_slag", amount=1}, {type="item", name="gold-ingot", amount=1}}
    data.raw.recipe["fu_gold_ingot_recipe"].main_product = "gold-ingot"
    rm.AddIngredient("fu_gold_ingot_recipe", "fi_arc_gold", 825, 825)
    --data.raw.recipe["fu_gold_plate_recipe"] = nil
    tf.removeRecipeUnlock("fu_gold_ingot_tech", "fu_gold_plate_recipe")
    --nukeItem("fu_materials_gold_ingot")
  else
    if mods["bzgold"] then
      --I want that tech obliterated
      --data.raw.technology["fu_gold_ingot_tech"] = nil
      --data.raw.recipe["fu_gold_ingot_recipe"] = nil
      --data.raw.recipe["fu_gold_plate_recipe"] = nil
      --nukeItem("fu_materials_gold_ingot")
    else
      --data.raw.recipe["fu_gold_plate_recipe"].results = {{type="item", name="gold-plate", amount=2}}
      --data.raw.recipe["fu_gold_plate_recipe"].main_product = "gold-plate"
    end
  end

  --fission era
  rm.RemoveIngredient("electric-engine-unit", "fi_materials_gold", 99999, 99999)
  if not (mods["BrassTacks"] or mods["IfNickel"]) then
    rm.ReplaceProportional("fi_crusher_recipe", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_fiberer_recipe", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_compound_machine_recipe", "engine-unit", "electric-engine-unit", 0.67)
    tf.addPrereq("fi_crusher_tech", "electric-engine-unit")
  end

  rm.AddIngredient("fi_fiberer_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_compound_machine_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_crusher_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_refinery_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_robo_charger_recipe", "hv-power-regulator", 5, 5)
  rm.AddIngredient("fi_ki_circuit_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_ki_beacon_recipe", "hv-power-regulator", 1, 1)
  rm.AddIngredient("fi_ki_core_recipe", "hv-power-regulator", 10, 10)

  --fusion era
  rm.AddIngredient("fu_activator_recipe", "hv-power-regulator", 10, 10)
  rm.AddIngredient("fu_fusor_recipe", "hv-power-regulator", 10, 10)
  rm.AddIngredient("fu_lab_recipe", "hv-power-regulator", 10, 10)
  rm.AddIngredient("fu_magnet_recipe", "hv-power-regulator", 10, 10)

  rm.AddIngredient("fu_tech_sign_recipe", "integrated-circuit", 1, 1)
end
