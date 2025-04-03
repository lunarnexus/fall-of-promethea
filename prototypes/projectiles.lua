
-- custom Promethium Radiation Explosion
local promethium_explosion = {
    type = "explosion",
    name = "promethium-explosion",
    flags = {"not-on-map"},
    animations = {
      {
        filename = "__base__/graphics/icons/poison-capsule.png",  -- dummy image
        priority = "high",
        width = 64,        
        height = 64,
        scale = 2.0,       -- Scale up for visibility
        shift = {0, 0},
        tint = {r = 1, g = 0.1, b = 0.1, a = 0.9}  -- Red tint for effect
    }
    
    },
    light = {intensity = 1, size = 12, color = {r = 1, g = 0.2, b = 0.2}},  -- Red glow
    smoke = "smoke-fast",
    smoke_count = 3,
    smoke_slow_down_factor = 1,
    created_effect = {
        type = "area",
        radius = 9,  -- 5-tile radius for the area damage
        force_condition = "all",
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "damage",
                    damage = {amount = 88, type = "radiation"}  -- Radiation area damage
                },
                {
                  type = "create-sticker", sticker = "promethium-radiation-sticker-small" -- Apply Radiation damage stickers
                },
                {
                    type = "create-entity",
                    entity_name = "big-explosion",  -- Additional explosion visuals
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
  
  --Promethium Radiation Stickers
  local promethium_radiation_sticker = table.deepcopy(data.raw["sticker"]["slowdown-sticker"])
    promethium_radiation_sticker.name = "promethium-radiation-sticker"
    promethium_radiation_sticker.duration_in_ticks = 600  -- Lasts 10 seconds
    promethium_radiation_sticker.target_movement_modifier = 0.5  -- 20% slower
    promethium_radiation_sticker.damage_per_tick = {
      amount = 0.5,  -- Damage per tick
      type = "radiation"  
    }
    promethium_radiation_sticker.animation = table.deepcopy(data.raw["sticker"]["slowdown-sticker"].animation)
    promethium_radiation_sticker.animation.tint = { r = 0.1, g = 0.3, b = 0.3, a = 0.4 }  
  
  -- Promethium Radiaton Sticker (Small)
  local promethium_radiation_sticker_small = table.deepcopy(data.raw["sticker"]["slowdown-sticker"])
    promethium_radiation_sticker_small.name = "promethium-radiation-sticker-small"
    promethium_radiation_sticker_small.duration_in_ticks = 300  -- Lasts 5 seconds
    promethium_radiation_sticker_small.target_movement_modifier = 0.8  -- 20% slower
    promethium_radiation_sticker_small.damage_per_tick = {
      amount = 0.1,  -- Damage per tick
      type = "radiation"  
    }
    promethium_radiation_sticker_small.animation = table.deepcopy(data.raw["sticker"]["slowdown-sticker"].animation)
    promethium_radiation_sticker_small.animation.tint = { r = 0.1, g = 0.3, b = 0.3, a = 0.4 }  
    
-- Promethium Bullet Projectile with Radiation Damage
local promethium_bullet_projectile = {
    type = "projectile",
    name = "promethium-bullet-projectile",
    flags = {"not-on-map"},
    acceleration = 0.005,
    animation = {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high",
      tint = { r = 1, g = 0.4, b = 0.4, a = 0.4 }  -- Red tint applied
    },
    -- Action on impact
    action = {
      {
        type = "area",  -- AoE effect
        radius = 3,  -- Small explosion radius
        force = "enemy",
        action_delivery = {
          type = "instant",
          target_effects = {
            -- Explosion visual effect
            {
              type = "create-entity",
              entity_name = "explosion",  -- Default explosion entity
              trigger_created_entity = true
            },
            -- AoE explosion damage
            {
            type = "damage",
            damage = { amount = 3, type = "explosion" }
            },
            {
            type = "damage",
            damage = { amount = 7, type = "radiation" }  -- Small radiation hit
            },
            {
            type = "damage",
            damage = { amount = 6, type = "physical" }  
            }
          }
        }
      }
    }
}  
  -- Promethium Grenade projectile
  local promethium_grenade_projectile = table.deepcopy(data.raw["projectile"]["grenade"])
  promethium_grenade_projectile.name = "promethium-grenade"
  
  promethium_grenade_projectile.action = {
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
            -- Standard explosion
            { type = "create-entity", entity_name = "massive-explosion" },
            {
                type = "create-entity",
                entity_name = "small-scorchmark-tintable",
                check_buildability = true
            },
            { type = "invoke-tile-trigger", repeat_count = 1 },
            { type = "damage", damage = { amount = 35, type = "explosion"} },
            { type = "damage", damage = { amount = 5, type = "radiation"} },
            -- Apply Radiation Sticker
            {
                type = "nested-result",
                action = {
                type = "area",
                radius = 7,  -- Explosion radius
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        { type = "create-sticker", sticker = "promethium-radiation-sticker" },
                        { type = "push-back", distance = 2 }
                    }
                }
                }
            },
            {
                type = "destroy-decoratives",
                from_render_layer = "decorative",
                to_render_layer = "object",
                include_soft_decoratives = true,
                include_decals = false,
                invoke_decorative_trigger = true,
                decoratives_with_trigger_only = false,
                radius = 2.25
            }
        }
      }
    }
  }
--[[ Plasma Projector custom beam and chain
local plasma_projector_beam = table.deepcopy(data.raw["beam"]["chain-tesla-turret-beam-start"])
    plasma_projector_beam.name = "plasma-projector-beam"
    -- Insert radiation damage into target_effects
    table.insert(plasma_projector_beam.action.action_delivery.target_effects, {
        type = "damage",
        damage = {amount = 60, type = "radiation"}
})
    -- Reduce electric damage
    for _, effect in pairs(plasma_projector_beam.action.action_delivery.target_effects) do
        if effect.type == "damage" and effect.damage.type == "electric" then
            effect.damage.amount = 60
            break  -- Stops after updating the first matching chain effect
        end
    end
    -- Replace __space-age__ with __fall-of-promethea__ in some of the image files
    replace_strings_in_table(plasma_projector_beam.graphics_set.beam.start, "__space-age__", "__fall-of-promethea__")
    replace_strings_in_table(plasma_projector_beam.graphics_set.beam.ending, "__space-age__", "__fall-of-promethea__")

local plasma_projector_chain = table.deepcopy(data.raw["chain-active-trigger"]["chain-tesla-turret-chain"])
    plasma_projector_chain.name = "plasma-projector-chain"
    plasma_projector_chain.fork_chance = 0.5
    plasma_projector_chain.max_range_per_jump = 27
    plasma_projector_chain.max_jumps = 16
]]
-- Promethium Rocket
local promethium_rocket_projectile = table.deepcopy(data.raw["projectile"]["explosive-rocket"])

promethium_rocket_projectile.name = "promethium-rocket-projectile"
promethium_rocket_projectile.animation.tint = {r = 1, g = 0.2, b = 0.2, a = 1} -- Red glow
promethium_rocket_projectile.action = {
    type = "direct",
    radius = 6.5,
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "damage",
                damage = { amount = 100, type = "radiation" } -- Custom radiation damage
            },
            {
              type = "damage",
              damage = { amount = 100, type = "explosion" } 
            },
            {
                type = "create-entity",
                entity_name = "big-explosion" -- Use vanilla explosion for visuals
            },
            {
                type = "create-sticker",
                sticker = "promethium-radiation-sticker-small" -- Applies lingering radiation
            }
        }
    }
}
-- Ion Cannon Projectile -- 
local ion_cannon_projectile = table.deepcopy(data.raw["projectile"]["explosive-rocket"])

ion_cannon_projectile.name = "ion-cannon-projectile"
ion_cannon_projectile.acceleration = 0.5
ion_cannon_projectile.rotatable = false
ion_cannon_projectile.animation = {
  filename = "__fall-of-promethea__/graphics/entity/ion-cannon/ion-cannon-projectile2.png",
  draw_as_glow = true, -- Makes it appear like glowing plasma
  priority = "high",
  width = 256,
  height = 256,
  frame_count = 1,
  scale = 0.45, -- Adjust size as needed
}
ion_cannon_projectile.action = {
    type = "area",
    radius = 5,
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "damage",
                damage = { amount = 200, type = "electric" } -- High-energy electric damage
            },
            {
                type = "damage",
                damage = { amount = 100, type = "radiation" } 
            },
            {
              type = "damage",
              damage = { amount = 50, type = "fire" } 
            },
            {
              type = "damage",
              damage = { amount = 50, type = "laser" } 
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
              type = "create-sticker",
              sticker = "promethium-radiation-sticker-small" -- Applies lingering radiation
            },
            {
              initial_height = 0,
              max_radius = 5,
              offset_deviation = {
                {
                  -5,
                  -5
                },
                {
                  5,
                  5
                }
              },
              repeat_count = 240,
              smoke_name = "artillery-smoke",
              speed_from_center = 0.1,
              speed_from_center_deviation = 0.01,
              type = "create-trivial-smoke"
            }
        }
    }
}

data:extend({
  promethium_explosion,
  promethium_radiation_sticker,
  promethium_radiation_sticker_small,
  promethium_bullet_projectile,
  promethium_grenade_projectile,
  promethium_rocket_projectile,
  ion_cannon_projectile
})