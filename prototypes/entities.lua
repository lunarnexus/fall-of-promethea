-- Promethium Wall -- 
local promethium_wall = table.deepcopy(data.raw["wall"]["stone-wall"])

promethium_wall.name = "promethium-wall"
promethium_wall.icons = {
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

    promethium_wall.minable.result = "promethium-wall"
    promethium_wall.max_health = 600  -- Custom health if desired

    -- Apply Promethium Wall resistances
    promethium_wall.resistances = {
    { type = "physical", decrease = 3, percent = 80 },
    { type = "explosion", decrease = 5, percent = 80 },
    { type = "fire", percent = 100 },
    { type = "radiation", percent = 90 }, -- new radiation damage type
    { type = "impact", decrease = 300, percent = 99 },  -- For asteroid impacts
    { type = "acid", decrease = 2, percent = 50 },
    { type = "poison", decrease = 0, percent = 50 },
    { type = "laser", percent = 60 },
    { type = "electric", percent = 50 }
    }

    -- Apply red tint to wall graphics
    for _, variation in pairs(promethium_wall.pictures) do
        if variation.layers then
            for _, layer in pairs(variation.layers) do
            if not layer.draw_as_shadow then
                layer.tint = {r = 1, g = 0.4, b = 0.5, a = 0.3}  -- Apply tint to non-shadow layers
            end
            end
        elseif variation.filename then
            variation.tint = {r = 1, g = 0.4, b = 0.5, a = 0.3}
        end
    end

    -- Ensure the wall connects and merges like vanilla walls
    promethium_wall.fast_replaceable_group = "wall"
    promethium_wall.visual_merge_group = 0

    -- Use wall remnants
    promethium_wall.corpse = "wall-remnants"

-- Promethium Thruster -- 
local promethium_thruster = table.deepcopy(data.raw["thruster"]["thruster"])

    promethium_thruster.name = "promethium-thruster"
    promethium_thruster.icons = {
        {
            icon = "__space-age__/graphics/icons/thruster.png",
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.4, a = 0.2}
        }
    }
    promethium_thruster.dying_explosion = "medium-explosion"

    -- Enhanced Thrust Performance
    -- promethium_thruster.min_performance = {fluid_volume = 0.1, fluid_usage = 0.1, effectivity = 1}
    -- promethium_thruster.max_performance = {fluid_volume = 0.8, fluid_usage = 2, effectivity = 0.51}
    promethium_thruster.min_performance = {fluid_volume = 0.1, fluid_usage = 0.1, effectivity = 1}
    promethium_thruster.max_performance = {fluid_volume = 0.8, fluid_usage = 2, effectivity = 0.93}
    promethium_thruster.allow_run_time_change_of_is_military_target = true
    promethium_thruster.minable.result = "promethium-thruster"
    promethium_thruster.resistances = {
        { type = "radiation", percent = 50 }  -- Radiation resistance
    }

    -- Apply red tint to working visualisations (Thruster Lights)
    promethium_thruster.graphics_set.working_visualisations[5].animation.filenames = {
        "__fall-of-promethea__/graphics/entity/thruster/thruster-light-1.png",
        "__fall-of-promethea__/graphics/entity/thruster/thruster-light-2.png"
    }
    promethium_thruster.graphics_set.flame_effect.filename = "__fall-of-promethea__/graphics/entity/thruster/thruster-flame.png"
    promethium_thruster.graphics_set.animation = util.sprite_load("__fall-of-promethea__/graphics/entity/thruster/thruster",
        {
        animation_speed = 0.5,
        frame_count = 64,
        scale = 0.5,
        shift = {0,3}
        })

-- Hidden Power Consumer for Promethium Thruster
local hidden_power_consumer = {
    type = "electric-energy-interface",
    name = "hidden-power-consumer",
    icon = "__fall-of-promethea__/graphics/entity/radiation_containment_64.png",  -- Using the same icon as Promethium Thruster
    icon_size = 64,
    picture = {
        filename = "__fall-of-promethea__/graphics/entity/radiation_containment_64.png",
        width = 64,
        height = 64,
        shift = {0, 0},
        scale = 1,
        draw_as_glow = true,
    },
    render_layer = "higher-object-above",
    selection_priority = 60,
    minable = nil,                -- No mining
    destructible = false,         -- Cannot be damaged or destroyed
    flags = {
        "placeable-neutral",
        "not-on-map",
        "not-deconstructable",    -- Prevent robots from targeting it
        "placeable-off-grid"
    },
    selectable_in_game = true,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.7, -0.7}, {0.7, 0.7}},
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        buffer_capacity = "12MJ",  -- Buffer to manage power fluctuations
        input_flow_limit = "16MW",  -- Power draw limit
        render_no_network_icon = false,  -- Ensure it shows in the Power UI
    },
    energy_production = "0kW",
    energy_usage = "12.1MW",  -- Constant Power draw.  A little more than a bolt of lightning.  

}
-- Hidden Power Draw for Thruster -- 
local thruster_power_draw = table.deepcopy(hidden_power_consumer)
thruster_power_draw.name = "thruster-power-draw"
thruster_power_draw.icons = {
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

-- Promethium Accumulator --
local promethium_accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
promethium_accumulator.name = "promethium-accumulator"
promethium_accumulator.icons = {
    { icon = "__fall-of-promethea__/graphics/icons/accumulator.png", icon_size = 64 }
    }
    promethium_accumulator.energy_source.buffer_capacity = "6MJ"  -- 1.2x base
    promethium_accumulator.energy_source.input_flow_limit = "6MW" 
    promethium_accumulator.energy_source.output_flow_limit = "24MW"
    promethium_accumulator.dying_explosion = "medium-explosion"

    -- Apply custom animations from these functions
    promethium_accumulator.chargable_graphics.picture = promethium_accumulator_picture()
    promethium_accumulator.chargable_graphics.charge_animation = promethium_accumulator_charge()
    promethium_accumulator.chargable_graphics.discharge_animation = promethium_accumulator_discharge()

    -- Add light effect during charge/discharge
    -- promethium_accumulator.charge_light = {intensity = 0.3, size = 7, color = {r = 1, g = 1, b = 0.5}}
    -- promethium_accumulator.discharge_light = {intensity = 0.3, size = 7, color = {r = 1, g = 1, b = 0.5}}
    promethium_accumulator.resistances = {
        { type = "radiation", percent = 90 } -- new radiation damage type
        }

-- Promethium BCR Panel --
local promethium_bcr_panel = {
    type = "electric-energy-interface",  -- Correct prototype type
    name = "promethium-bcr-panel",
    icons = {
        {
            icon = "__base__/graphics/icons/solar-panel.png",  -- Base solar panel icon
            icon_size = 64
        },
        {
            icon = "__base__/graphics/icons/solar-panel.png",  -- Overlay with Promethium tint
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.4, a = 0.4}  -- Promethium red tint
        }
    },
    quality_config = { 
        energy_production = { base = 32, per_tier = 20}
    },
    gui_mode = "none",
    energy_source = {
        type = "electric",
        buffer_capacity = "32kJ",        -- Small buffer
        usage_priority = "solar",        -- Behaves like a solar panel in grid priority
        output_flow_limit = "32kW",      -- Constant 42kW output
        input_flow_limit = "0kW",        -- Prevents it from consuming power
        render_no_power_icon = false,     -- No power warning icon
        production_type = "output"
    },
    energy_usage = "0kW",  
    energy_production = "32kW",          -- Constant power output
    minable = {mining_time = 0.5, result = "promethium-bcr-panel"},
    max_health = 150,
    fast_replaceable_group = "solar-panel",
    resistances = {
        { type = "radiation", percent = 90 }  -- Radiation resistance
    },
    flags = {
        "placeable-neutral",
        "player-creation"
    },
    corpse = "solar-panel-remnants",
    dying_explosion = "solar-panel-explosion",
    collision_box = {
        {-1.4, -1.4},
        {1.4, 1.4}
    },
    selection_box = {
        {-1.5, -1.5},
        {1.5, 1.5}
    },
    damaged_trigger_effect = {
        type = "create-entity",
        entity_name = "spark-explosion",
        offset_deviation = {
            {-0.5, -0.5},
            {0.5, 0.5}
        },
        offsets = {
            {0, 1}
        },
        damage_type_filters = "fire"
    },
    picture = {
        layers = {
            {
                filename = "__base__/graphics/entity/solar-panel/solar-panel.png",
                priority = "high",
                width = 230,
                height = 224,
                shift = {-0.09375, 0.109375},
                scale = 0.5,
                tint = {r = 1, g = 0.4, b = 0.4, a = 0.8}
            },
            {
                filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow.png",
                priority = "high",
                width = 220,
                height = 180,
                shift = {0.296875, 0.1875},
                draw_as_shadow = true,
                scale = 0.5
            }
        }
    },
    overlay = {
        layers = {
            {
                filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow-overlay.png",
                priority = "high",
                width = 214,
                height = 180,
                shift = {0.328125, 0.1875},
                scale = 0.5
            }
        }
    },
    impact_category = "glass"  
}

-- Promethium Plasma Projector --
local plasma_projector = table.deepcopy(data.raw["electric-turret"]["tesla-turret"])

plasma_projector.name = "plasma-projector"
plasma_projector.icons = {
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
replace_strings_in_table(plasma_projector.graphics_set.base_visualisation,
    "__space-age__/graphics/entity/tesla-turret/tesla-turret-base.png",
    "__fall-of-promethea__/graphics/entity/tesla-turret/tesla-turret-base.png")
plasma_projector.attack_parameters.ammo_type.energy_consumption = "24MJ" 
plasma_projector.energy_source.buffer_capacity = "25MJ"
plasma_projector.attack_parameters.range = 36
-- Use custom beam and chain
for _, effect in pairs(plasma_projector.attack_parameters.ammo_type.action.action_delivery.target_effects) do
    if effect.type == "nested-result" and effect.action 
       and effect.action.action_delivery
       and effect.action.action_delivery.type == "beam" then
        effect.action.action_delivery.beam = "chain-plasma-turret-beam-start"
        break  -- Stop after finding the first matching beam effect
    end
end
for _, effect in pairs(plasma_projector.attack_parameters.ammo_type.action.action_delivery.target_effects) do
    if effect.type == "nested-result" and effect.action 
       and effect.action.action_delivery
       and effect.action.action_delivery.type == "chain" then
        effect.action.action_delivery.chain = "chain-plasma-turret-chain"
        break  -- Stops after updating the first matching chain effect
    end
end

-- Ion Cannon -- 
local ion_cannon = table.deepcopy(data.raw["ammo-turret"]["rocket-turret"])

ion_cannon.name = "ion-cannon"
ion_cannon.icons = {
    {
        icon = "__fall-of-promethea__/graphics/icons/ion-cannon.png",
        icon_size = 256,
        mipmap_count = 4
    }
}
ion_cannon.minable.result = "ion-cannon"
ion_cannon.attack_parameters.ammo_category = "ion-cannon-ammo"  -- Uses only Ion Cannon ammo
ion_cannon.attack_parameters.min_attack_distance = 10 -- Which one?
-- ion_cannon.attack_parameters.min_range = 10  -- Which one?
ion_cannon.attack_parameters.warmup = 120
ion_cannon.rotation_speed = 0.002
ion_cannon.attack_parameters.cooldown = 90 
ion_cannon.attack_parameters.range = 100  
ion_cannon.inventory_size = 1
ion_cannon.automated_ammo_count = 2
ion_cannon.attack_parameters.projectile_center = {0,0}  -- Adjusts the vertical offset
ion_cannon.attack_parameters.projectile_creation_distance = 0
ion_cannon.attack_parameters.ammo_type = {
    category = "ion-cannon-ammo",
    energy_consumption = "10kJ",
    action = {
        type = "direct",
        action_delivery = {
            type = "projectile",
            projectile = "ion-cannon-projectile",
            starting_speed = 1 
        }
    }
}
ion_cannon.graphics_set.base_visualisation = {
    animation = {
        layers = {
            {
                filename = "__fall-of-promethea__/graphics/entity/ion-cannon/ion-cannon-base.png",
                width = 202,
                height = 168,
                frame_count = 1,
                scale = 0.55,
                shift = {0, 0}
            }
        }
    }
}
local ion_turret_head_animation = {
    layers = {
        {
            filenames = {
                "__fall-of-promethea__/graphics/entity/ion-cannon/ion-cannon-head-1.png",
                "__fall-of-promethea__/graphics/entity/ion-cannon/ion-cannon-head-2.png",
                "__fall-of-promethea__/graphics/entity/ion-cannon/ion-cannon-head-3.png"
            },
            direction_count = 64,
            height = 350,
            line_length = 1,
            lines_per_file = 22,
            scale = 0.35,
            shift = { 0,0 },
            slice = 1,
            width = 350
        }
    }
}
ion_cannon.folded_animation = ion_turret_head_animation
ion_cannon.preparing_animation = ion_turret_head_animation
ion_cannon.prepared_animation = ion_turret_head_animation
ion_cannon.attacking_animation = ion_turret_head_animation
ion_cannon.preparing_animation = ion_cannon.folded_animation
ion_cannon.prepared_animation = ion_cannon.folded_animation
ion_cannon.attacking_animation = ion_cannon.folded_animation
-- Hidden Power Draw -- 
local ion_cannon_power_draw = table.deepcopy(hidden_power_consumer)
ion_cannon_power_draw.name = "ion-cannon-power-draw"
ion_cannon_power_draw.icons = {
    {
        icon = "__fall-of-promethea__/graphics/icons/ion-cannon.png",
        icon_size = 256,
        mipmap_count = 4
    }
}
ion_cannon_power_draw.picture.scale = 0.65

data:extend({
    promethium_wall,
    promethium_thruster,
    hidden_power_consumer,
    thruster_power_draw,
    promethium_accumulator,
    promethium_bcr_panel,
    plasma_projector,
    ion_cannon,
    ion_cannon_power_draw
})





