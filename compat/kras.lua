local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if mods["advanced-chemical-plant"] and not mods["Krastorio2"] then
  if not (mods["BrassTacks"] or mods["IfNickel"]) then
    rm.AddIngredient("kr-advanced-chemical-plant", "electric-engine-unit", 4, 4) --nobody can escape my insistence on shoving this item in every high end recipe. nobody!
  end
  rm.ReplaceIngredient("kr-advanced-chemical-plant", "effectivity-module", "hv-power-regulator", 4, 4)
  rm.ReplaceIngredient("kr-advanced-chemical-plant", "speed-module", "integrated-circuit", 32, 32)
end

if mods["AdvancedAssemblyMachineStandalone"] and not mods["Krastorio2"] then
  rm.RemoveIngredient("assembling-machine-3", "electric-engine-unit", 99999, 99999) -- :O
  if parts.experimental then
    rm.AddIngredient("kr-advanced-assembling-machine", "hardened-hull", 12, 12)
  end
end

if mods["advanced-centrifuge"] then
  if not mods["Krastorio2"] then
    --K2's ECU costs power regulators.
    rm.ReplaceIngredient("k11-advanced-centrifuge", "processing-unit", "hv-power-regulator", 10, 10)
  end
end

if mods["Krastorio2"] then
  rm.RemoveIngredient("energy-control-unit", "electronic-components", 9, 9)
  rm.AddIngredient("energy-control-unit", "hv-power-regulator", 1, 1)

  rm.ReplaceProportional("kr-tesla-coil", "copper-cable", "advanced-cable", 1/4)

  if  not data.raw.item["tracker"] then
    rm.ReplaceProportional("kr-medium-passive-provider-container", "electronic-circuit", "transceiver", 1/4)
    rm.ReplaceProportional("kr-medium-active-provider-container", "electronic-circuit", "transceiver", 1/4)
    rm.ReplaceProportional("kr-medium-requester-container", "electronic-circuit", "transceiver", 1/4)
    rm.ReplaceProportional("kr-medium-buffer-container", "electronic-circuit", "transceiver", 1/4)
    rm.ReplaceProportional("kr-medium-storage-container", "electronic-circuit", "transceiver", 1/4)

    rm.ReplaceProportional("kr-big-passive-provider-container", "electronic-circuit", "transceiver", 1/5)
    rm.ReplaceProportional("kr-big-active-provider-container", "electronic-circuit", "transceiver", 1/5)
    rm.ReplaceProportional("kr-big-requester-container", "electronic-circuit", "transceiver", 1/5)
    rm.ReplaceProportional("kr-big-buffer-container", "electronic-circuit", "transceiver", 1/5)
    rm.ReplaceProportional("kr-big-storage-container", "electronic-circuit", "transceiver", 1/5)
  end

  rm.AddIngredient("kr-advanced-solar-panel", parts.gold, 5, 5)

  rm.ReplaceProportional("kr-advanced-chemical-plant", "electronic-components", "integrated-circuit", 1/2)
  rm.ReplaceProportional("kr-quantum-computer", "electronic-components", "integrated-circuit", 1/2)

  rm.ReplaceProportional("kr-advanced-radar", "advanced-circuit", "hv-power-regulator", 1/5)
  rm.AddIngredient("kr-advanced-radar", "transceiver", 2, 2)

  if not mods["aai-industry"] then
    rm.AddIngredient("kr-electric-mining-drill-mk2", "hv-power-regulator", 1, 1)
    tf.addPrereq("kr-electric-mining-drill-mk2", "high-voltage-equipment")
  end

  if not mods["LasingAround"] then
    rm.ReplaceIngredient("kr-advanced-splitter", "advanced-circuit", "integrated-circuit", 2, 2)
  end
  rm.ReplaceProportional("kr-small-roboport", "electronic-components", "integrated-circuit", 1)
  rm.ReplaceProportional("kr-nuclear-locomotive", "electronic-components", "integrated-circuit", 1/5)

  tf.addRecipeUnlock("kr-advanced-chemistry", "ammonia-from-potassium-nitrate")

  rm.AddIngredient("kr-matter-plant", "advanced-cable", 25, 25)
  rm.AddIngredient("kr-matter-assembler", "advanced-cable", 25, 25)
  rm.AddIngredient("kr-stabilizer-charging-station", "advanced-cable", 5, 5)
end

if mods["FluidMustFlow"] then
  rm.AddIngredient("duct-end-point-intake", "hv-power-regulator", 1, 1)
  rm.AddIngredient("duct-end-point-outtake", "hv-power-regulator", 1, 1)
end
