data:extend({
    {
        -- Tech Unlock Distance Modifier
        type = "double-setting",
        name = "fop_tech_distance_multiplier",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 19.0,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "enable-aquilo-promethium",
        setting_type = "startup",
        default_value = true,
        order = "b"
    } 
})
