
-- Add science to the recipes for various promethium science, if installed.  
if mods["Cerys-Moon-of-Fulgora"] then

    table.insert(data.raw.technology["promethium-space-travel"].unit.ingredients, {
        "cerysian-science-pack", 1
        })

    table.insert(data.raw.technology["promethium-power-handling"].unit.ingredients, {
        "cerysian-science-pack", 1
        })

end