-- Add science to the recipes for various promethium science, if installed.  
if mods["castra"] then

    table.insert(data.raw.technology["promethium-weapons-tech"].unit.ingredients, {
        "battlefield-science-pack", 1
        })
end






