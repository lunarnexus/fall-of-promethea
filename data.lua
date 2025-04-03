--Helper function to replace strings inside of tables
function escape_pattern(str)
    return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end
function replace_strings_in_table(table_data, search_str, replace_str)
    for key, value in pairs(table_data) do
        if type(value) == "table" then
            replace_strings_in_table(value, search_str, replace_str)  -- Recursively search inside nested tables
        elseif type(value) == "string" then
            if value:find(search_str, 1, true) then
                table_data[key] = value:gsub(escape_pattern(search_str), replace_str)  -- Perform replacement
            end
        end
    end
end

-- Add a custom damage type "Radiation" for use with Promethium 
data:extend({
    {
        type = "damage-type",
        name = "radiation"
    }
})
-- Custom ammo category for Ion Cannon
data:extend({
    {
        type = "ammo-category",
        name = "ion-cannon-ammo",
        bonus_gui_order = "b"
    }
})

-- Load item and recipe definitions
require("prototypes.beams")  
require("prototypes.active-triggers")  
require("prototypes.animation")  
require("prototypes.projectiles")
require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technology")
require("tips-and-tricks")
-- Compatability and Patches
require("prototypes.patches.asteroid-promethium")
require("compat.planet-muluna")
--require("compat.Cerys-Moon-of-Fulgora")
require("compat.castra")
  






