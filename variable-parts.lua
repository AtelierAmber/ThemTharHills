local parts = {}

parts.heavyGyro = false
if mods["BrassTacks-Updated"] and settings.startup["brasstacks-experimental-intermediates"].value and (settings.startup["brasstacks-gyro-override"].value or not mods["bzsilicon"]) then
  parts.heavyGyro = true
end

parts.aquaregia  = settings.startup["themtharhills-enable-aqua-regia"].value and (mods["Krastorio2"] or mods["bzchlorine"]) and not (mods["Krastorio2"] and mods["bztungsten"] and mods["BrimStuff-Updated"] and mods["FreightForwarding"])

function parts.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {type="item", name=v, amount=quantities[k]}
    end
  end
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {type="item", name=item, amount=amount}
  end
end

if mods["bzfoundry"] and not settings.startup["bzfoundry-minimal"].value then
  parts.foundryEnabled = true
else
  parts.foundryEnabled = false
end

if mods["248k"] then
  --THE STANDARD DEVICE TO ALWAYS PREFIX IDS IS PESTILENCE. SOMETIMES COLLISIONS ARE DESIRABLE.
  --(generally you want intermediates to collide and entities to be separate but it is often more subtle than that.)
  parts.gold = "fi_materials_gold"
  parts.wire = "gr_materials_gold_wire"
else
  parts.gold = "gold-plate"
  parts.wire = "gold-wire"
end

return parts
