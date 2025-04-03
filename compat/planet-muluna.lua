-- Add science to the recipes for various promethium science, if installed.  
if mods["planet-muluna"] then

    table.insert(data.raw.technology["promethium-space-travel"].unit.ingredients, {
        "interstellar-science-pack", 1
        })

    table.insert(data.raw.technology["promethium-power-handling"].unit.ingredients, {
        "interstellar-science-pack", 1
        })

    table.insert(data.raw.technology["promethium-weapons-tech"].unit.ingredients, {
        "interstellar-science-pack", 1
        })
end






