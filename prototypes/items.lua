local promethium_gravel = {
    type = "item",
    name = "promethium-gravel",
    icons = {
        {
            icon = "__base__/graphics/icons/stone.png",
            icon_size = 64,
        },
        {
            icon = "__base__/graphics/icons/stone.png",
            icon_size = 64,
            tint = {r = 0.9, g = 0.5, b = 0.6, a = 0.8}
        }
    },
    stack_size = 10,
    weight = 500,
    subgroup = "raw-material",
    order = "b[promethium-gravel]",
    spoil_result = "iron-ore",
    spoil_ticks = 27.3 * 60 * 60 -- The days in a lunar cycle, seemed appropriate
}

local promethium_ore = {
    type = "item",
    name = "promethium-ore",
    icons = {
        {
            icon = "__space-age__/graphics/icons/lithium.png",
            icon_size = 64,
        },
        {
            icon = "__space-age__/graphics/icons/lithium.png",
            icon_size = 64,
            tint = {r = 1, g = 0.3, b = 0.4, a = 0.7}
        }
    },
    stack_size = 10,
    weight = 500,
    subgroup = "raw-material",
    order = "c[promethium-ore]",
    spoil_result = "iron-ore",
    spoil_ticks = 38 * 60 * 60  -- The Stargate can't do any better
}

local promethium_plate = {
    type = "item",
    name = "promethium-plate",
    icons = {
        {
            icon = "__base__/graphics/icons/iron-plate.png",  -- Placeholder icon
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.5, a = 1},
            draw_as_light = true
        }
    },
    stack_size = 10,
    weight = 500,
    spoil_ticks = 20 * 60, -- 20 seconds, purely for balance and tuning
    spoil_result = "promethium-plate",
    spoil_to_trigger_result = {
        items_per_trigger = 10,  -- should this be a full stack?,
        trigger = {
            type = "area",  -- Apply the effect over an area
            radius = 6,     
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 0.1, type = "radiation" }  -- Immediate damage to non-living entities.
                    },
                    {
                        type = "create-sticker", sticker = "promethium-radiation-sticker-small" -- Apply Radiation damage stickers
                    },
                    {
                        type = "play-sound",
                        sound = {
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.7,
                                pitch = 0.8  -- Lower pitch for ominous tone
                            },
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.6,
                                pitch = 1.2  -- Higher pitch for contrast
                            }
                        }
                    }
                }
            }
        }
    },
    subgroup = "raw-material",
    order = "d[promethium-plate]"

}
-- Unstable Isotope
local unstable_isotope = {
    type = "item",
    name = "unstable-isotope",
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/unstable-isotope.png",  
            icon_size = 64,
            draw_as_light = true
        }
    },
    stack_size = 1,
    subgroup = "intermediate-product",
    order = "f[unstable-isotope]",
    fuel_category = "nuclear",               -- Works in furnaces, boilers, vehicles
    fuel_value = "42GJ",                     -- Gives lots of power
    spoil_ticks = 10.77 * 60 * 60,           -- the price of a cheese pizza and a large soda
    spoil_results = "unstable-isotope",
    spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            type = "area",
            radius = 5,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 42, type = "radiation" }  -- Immediate damage to non-living entities.  This is the answer.
                    },
                    {
                        type = "create-sticker", sticker = "promethium-radiation-sticker-small" -- Apply Radiation damage stickers
                    },
                    {
                        type = "play-sound",
                        sound = {
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.7,
                                pitch = 0.8  -- Lower pitch for ominous tone
                            },
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.6,
                                pitch = 1.2  -- Higher pitch for contrast
                            }
                        }
                    }
                }
            }
        }
    }
}

-- Stable Isotope
local stable_isotope = {
    type = "item",
    name = "stable-isotope",
    auto_recycle = false, -- does this actuall work?
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/stable-isotope.png",  
            icon_size = 64,
        }
    },
    stack_size = 10,
    subgroup = "intermediate-product",
    order = "g[stable-isotope]",
    fuel_category = "chemical",               -- Works in furnaces, boilers, vehicles
    fuel_value = "4.2GJ",                     
    fuel_acceleration_multiplier = 2.5,       
    fuel_top_speed_multiplier = 1.25
}

-- Promethium Wall Item Definition using table.deepcopy
local promethium_wall_item = table.deepcopy(data.raw["item"]["stone-wall"])

promethium_wall_item.name = "promethium-wall"
promethium_wall_item.icons = {
    {
        icon = "__base__/graphics/icons/wall.png",
        icon_size = 64,
    },
    {
        icon = "__base__/graphics/icons/wall.png",
        icon_size = 64,
        tint = {r = 1, g = 0.4, b = 0.5, a = 0.4}  -- Promethium red tint
    }
}
promethium_wall_item.subgroup = "defensive-structure"
promethium_wall_item.order = "a[stone-wall]-b[promethium-wall]"
promethium_wall_item.place_result = "promethium-wall"
promethium_wall_item.stack_size = 100
promethium_wall_item.weight = 1000

-- Promethium Thruster
local promethium_thruster_item = table.deepcopy(data.raw["item"]["thruster"])

promethium_thruster_item.name = "promethium-thruster"
promethium_thruster_item.icons = {
    {
        icon = "__space-age__/graphics/icons/thruster.png",
        icon_size = 64,
    },
    {
        icon = "__space-age__/graphics/icons/thruster.png",
        icon_size = 64,
        tint = {r = 1, g = 0.4, b = 0.4, a = 0.5}  -- Promethium red tint
    }
}
promethium_thruster_item.subgroup = "space-platform"
promethium_thruster_item.order = "f[promethium-thruster]"
promethium_thruster_item.place_result = "promethium-thruster"  -- Ensure this matches the entity name
promethium_thruster_item.stack_size = 10

local hidden_radiation_source =     {
    type = "item",
    name = "hidden-radiation-source",
    icon = "__base__/graphics/icons/uranium-235.png",  -- Placeholder icon
    icon_size = 64,
    subgroup = "other",
    order = "z",
    stack_size = 1,
    spoil_ticks = 3 * 60, 
    spoil_result = "hidden-radiation-source",
    spoil_to_trigger_result = {
        items_per_trigger = 1,  -- should this be a full stack?,
        trigger = {
            type = "area",  -- Apply the effect over an area
            radius = 5,     
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 3, type = "radiation" }  -- Immediate damage to non-living entities.
                    },
                    --{
                    --    type = "create-sticker", sticker = "promethium-radiation-sticker-small" -- Apply Radiation damage stickers
                    --},
                    {
                        type = "play-sound",
                        sound = {
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.7,
                                pitch = 0.8  -- Lower pitch for ominous tone
                            },
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.6,
                                pitch = 1.2  -- Higher pitch for contrast
                            }
                        }
                    }
                }
            }
        }
    }
}

-- Promethium Accumulator
local promethium_accumulator_item = table.deepcopy(data.raw["item"]["accumulator"])
    promethium_accumulator_item.name = "promethium-accumulator"
    promethium_accumulator_item.icons = {
        { icon = "__fall-of-promethea__/graphics/icons/accumulator.png", icon_size = 64 },
        { icon = "__fall-of-promethea__/graphics/icons/accumulator.png", icon_size = 64, tint = {r = 1, g = 0.4, b = 0.5, a = 0.4} }
    }
    promethium_accumulator_item.place_result = "promethium-accumulator"
    promethium_accumulator_item.order = "e[accumulator]-b[promethium-accumulator]"
    promethium_accumulator_item.subgroup = "energy"
    promethium_accumulator_item.stack_size = 50
    promethium_accumulator_item.weight = 40000

-- Promethium BCR Panel
local promethium_bcr_item = table.deepcopy(data.raw["item"]["solar-panel"])
    promethium_bcr_item.name = "promethium-bcr-panel"
    promethium_bcr_item.icons = {
        {
            icon = "__base__/graphics/icons/solar-panel.png",
            icon_size = 64
        },
        {
            icon = "__base__/graphics/icons/solar-panel.png",
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.5, a = 0.4}  -- Promethium red tint
        }
    }
    promethium_bcr_item.place_result = "promethium-bcr-panel"
    promethium_bcr_item.order = "d[solar-panel]-b[promethium-bcr-panel]"
    promethium_bcr_item.subgroup = "energy"
    promethium_bcr_item.stack_size = 50
    promethium_bcr_item.weight = 40000

-- Promethium Bullet Ammo using table.deepcopy
local promethium_bullet_ammo = table.deepcopy(data.raw["ammo"]["piercing-rounds-magazine"])

promethium_bullet_ammo.name = "promethium-bullet-magazine"
promethium_bullet_ammo.icons = {
    {
        icon = "__base__/graphics/icons/piercing-rounds-magazine.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/piercing-rounds-magazine.png",
        icon_size = 64,
        tint = { r = 1, g = 0.4, b = 0.4, a = 0.9 },  
        draw_as_light = true
    }
}
promethium_bullet_ammo.ammo_category = "bullet"
promethium_bullet_ammo.magazine_size = 10
promethium_bullet_ammo.subgroup = "ammo"
promethium_bullet_ammo.order = "a[basic-clips]-d[promethium-bullets]"
promethium_bullet_ammo.stack_size = 200

-- Custom Ammo Type
promethium_bullet_ammo.ammo_type = {
    action = {
        type = "direct",
        action_delivery = {
            type = "projectile",
            projectile = "promethium-bullet-projectile",
            starting_speed = 0.5,
            direction_deviation = 0.4,
            range_deviation = 0.1,
            source_effects = {
                { type = "create-explosion", entity_name = "explosion" }
            }, -- Added to prevent mod conflict
            target_effects = {
                {
                    type = "damage",
                    damage = { amount = 10, type = "physical" }
                }
            } -- Preserving expected ammo damage
        }
    }
}

-- Spoilage Mechanics
promethium_bullet_ammo.spoil_ticks = 4 * 60 * 60 * 60 -- 4 Hours

-- Promethium Grenade item
local promethium_grenade_item = table.deepcopy(data.raw["capsule"]["grenade"])
    promethium_grenade_item.name = "promethium-grenade"
    promethium_grenade_item.icons = {
    {
        icon = "__base__/graphics/icons/grenade.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/grenade.png",
        icon_size = 64,
        tint = { r = 1, g = 0.4, b = 0.5, a = 0.6 },  -- Promethium red tint
        draw_as_glow = true
    }
}
    promethium_grenade_item.icon_size = 64
    promethium_grenade_item.icon_mipmaps = 4
    promethium_grenade_item.subgroup = "capsule"
    promethium_grenade_item.order = "a[grenade]-c[promethium-grenade]"

    -- Link to the promethium grenade projectile
    promethium_grenade_item.capsule_action.attack_parameters.ammo_type.action = {
        type = "direct",
        action_delivery = {
            type = "projectile",
            projectile = "promethium-grenade",
            starting_speed = 0.4
        }
    }
    promethium_grenade_item.spoil_ticks = 4 * 60 * 60 * 60 -- 4 hours
    promethium_grenade_item.spoil_result = nil
    promethium_grenade_item.spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            type = "area",
            radius = 6,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 100, type = "radiation" }  -- Immediate damage to non-living entities.
                    },
                    {
                        type = "create-entity",
                        entity_name = "massive-explosion",  -- Use "big-explosion" or "explosion" if preferred
                    },
                    {
                        type = "create-sticker", sticker = "promethium-radiation-sticker" -- Apply Radiation damage stickers
                    },
                    {
                        type = "play-sound",
                        sound = {
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.7,
                                pitch = 0.8  -- Lower pitch for ominous tone
                            },
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.6,
                                pitch = 1.2  -- Higher pitch for contrast
                            }
                        }
                    }
                }
            }
        }
    }
-- Promethium Plasma Projector --
local plasma_projector_item = table.deepcopy(data.raw["item"]["tesla-turret"])

    plasma_projector_item.name = "plasma-projector"
    plasma_projector_item.place_result = "plasma-projector"
    plasma_projector_item.icons = {
        {
            icon = "__space-age__/graphics/icons/tesla-turret.png",
            icon_size = 64
        },
        {
            icon = "__space-age__/graphics/icons/tesla-turret.png",
            icon_size = 64,
            tint = {r = 1, g = 0.3, b = 0.4, a = 0.5} 
        }
    }

-- Promethum Rocket -- 
local promethium_rocket = table.deepcopy(data.raw["ammo"]["explosive-rocket"])

    promethium_rocket.name = "promethium-rocket"
    promethium_rocket.icons = {
        {
            icon = "__base__/graphics/icons/explosive-rocket.png",
            icon_size = 64,
        },
        {
            icon = "__base__/graphics/icons/explosive-rocket.png",
            icon_size = 64,
            tint = {r = 0.8, g = 0.2, b = 0.2, a = 0.7} -- Red tint for Promethium
        }
    }
    promethium_rocket.subgroup = "ammo"
    promethium_rocket.order = "d[rocket-launcher]-c[promethium-rocket]"
    
    -- Adjust projectile
    promethium_rocket.ammo_type.action.action_delivery.projectile = "promethium-rocket-projectile"
    promethium_rocket.spoil_ticks = 2 * 60 * 60 * 60         
    promethium_rocket.spoil_to_trigger_result = {
        items_per_trigger = 1,
        trigger = {
            type = "area",
            radius = 5,
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 1, type = "radiation" }  
                    },
                    {
                        type = "create-sticker", sticker = "promethium-radiation-sticker-small" 
                    },
                    {
                        type = "play-sound",
                        sound = {
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.7,
                                pitch = 0.8  -- Lower pitch for ominous tone
                            },
                            {
                                filename = "__base__/sound/accumulator-working-01.ogg",
                                volume = 0.6,
                                pitch = 1.2  -- Higher pitch for contrast
                            }
                        }
                    }
                }
            }
        }
    }

    -- Ion Cannon Ammo -- 
local ion_cannon_ammo = table.deepcopy(data.raw["ammo"]["explosive-rocket"])

ion_cannon_ammo.name = "ion-cannon-ammo"
ion_cannon_ammo.subgroup = "ammo"
ion_cannon_ammo.icons = {
    {
        icon = "__fall-of-promethea__/graphics/icons/ion-cannon-ammo.png",
        icon_size = 256,
        mipmap_count = 4
    }
}
ion_cannon_ammo.ammo_category = "ion-cannon-ammo"  -- Unique ammo category
ion_cannon_ammo.ammo_type.action.action_delivery.projectile = "ion-cannon-projectile"
ion_cannon_ammo.stack_size = 20

-- Ion Cannon Item -- 
local ion_cannon_item = {
    type = "item",
    name = "ion-cannon",
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/ion-cannon.png",
            icon_size = 256,
            mipmap_count = 4
        }
    },
    stack_size = 1,
    subgroup = "turret",
    order = "d[ion-cannon]",
    place_result = "ion-cannon"
}


data:extend({
    promethium_gravel,
    promethium_ore,
    promethium_plate,
    unstable_isotope,
    stable_isotope,
    promethium_wall_item,
    promethium_thruster_item,
    hidden_radiation_source,
    promethium_accumulator_item,
    promethium_bcr_item,
    promethium_bullet_ammo,
    promethium_grenade_item,
    plasma_projector_item,
    promethium_rocket,
    ion_cannon_ammo,
    ion_cannon_item
})

