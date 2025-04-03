-- prototypes/technology.lua -- 

-- Promethium Processing Technology
local promethium_processing = {
    type = "technology",
    name = "promethium-processing",
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
    prerequisites = {"promethium-science-pack"},
    effects = {
        {type = "unlock-recipe", recipe = "promethium-gravel"},
        {type = "unlock-recipe", recipe = "promethium-ore"},
        {type = "unlock-recipe", recipe = "promethium-plate"},
        {type = "unlock-recipe", recipe = "promethium-wall"}
    },
    unit = {
        count = 2000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    order = "c-c-a"
}

-- Isotope Processing Technology
local isotope_processing = {
    type = "technology",
    name = "isotope-processing",
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/unstable-isotope.png",
            icon_size = 64
        }
    },
    prerequisites = {"promethium-processing"},
    effects = {
        {type = "unlock-recipe", recipe = "unstable-isotope"},
        {type = "unlock-recipe", recipe = "stable-isotope-recycling"}
    },
    unit = {
        count = 3333,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    order = "c-c-b"
}

-- Promethium Space Travel Technology
local promethium_space_travel = {
    type = "technology",
    name = "promethium-space-travel",
    icons = {
        {
            icon = "__space-age__/graphics/technology/space-platform-thruster.png",
            icon_size = 256
        },
        {
            icon = "__space-age__/graphics/technology/space-platform-thruster.png",
            icon_size = 256,
            tint = {r = 1, g = 0.4, b = 0.5, a = 0.4}  -- Promethium red tint overlay
        }
    },
    prerequisites = {"promethium-processing", "isotope-processing"},
    effects = {
        {type = "unlock-recipe", recipe = "promethium-thruster"}
    },
    unit = {
        count = 3000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    order = "c-k-a"
}

-- Promethium Power Handling Technology
local promethium_power_handling = {
    type = "technology",
    name = "promethium-power-handling",
    icons = {
        { icon = "__fall-of-promethea__/graphics/icons/accumulator.png", icon_size = 64 }
    },
    prerequisites = {"electric-energy-accumulators", "promethium-processing", "isotope-processing"},
    effects = {
        {type = "unlock-recipe", recipe = "promethium-accumulator"},
        {type = "unlock-recipe", recipe = "promethium-bcr-panel"}
    },
    unit = {
        count = 3000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    order = "c-e-b"
}

-- Technology to Unlock Promethium Weapons
local promethium_weapons_tech = {
    type = "technology",
    name = "promethium-weapons-tech",
    icons = {
      {
        icon = "__base__/graphics/technology/military.png",  -- Use custom promethium tech icon if available
        icon_size = 256
      },
      {
        icon = "__base__/graphics/technology/military.png",
        icon_size = 256,
        tint = { r = 1, g = 0.4, b = 0.4, a = 0.4 },  -- Red tint overlay
        draw_as_light = true
      }
    },
    prerequisites = {"military-2", "explosives", "promethium-processing"},
    effects = {
      {
        type = "unlock-recipe",
        recipe = "promethium-bullet-magazine"
      },
      {
        type = "unlock-recipe",
        recipe = "promethium-grenade"
      }
    },
    unit = {
        count = 1210,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"electromagnetic-science-pack", 1},
            {"cryogenic-science-pack", 1},
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    order = "e-a-c"
  }
-- Technology to unlock Promethium Rockets
local promethium_rocket_tech = {
    type = "technology",
    name = "promethium-rocket-tech",
    icons = {
        {
            icon = "__base__/graphics/technology/rocketry.png",
            icon_size = 256
        },
        {
            icon = "__base__/graphics/technology/rocketry.png",
            icon_size = 256,
            tint = {r = 0.8, g = 0.2, b = 0.2, a = 0.7} -- Promethium red tint
        }
    },
    prerequisites = {"isotope-processing","promethium-weapons-tech"},
    unit = {
        count = 1e9,
        ingredients = {
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "promethium-rocket"
        }
    },
    order = "e-a",
    visible_when_disabled = true
}

-- Technology to unlock Plasma Projector
local plasma_projector_tech = {
    type = "technology",
    name = "plasma-projector-tech",
    icons = {
        {
            icon = "__space-age__/graphics/icons/tesla-turret.png",
            icon_size = 64
        },
        {
            icon = "__space-age__/graphics/icons/tesla-turret.png",
            icon_size = 64,
            tint = {r = 1, g = 0.3, b = 0.4, a = 0.5} 
        }
    },
    prerequisites = {"isotope-processing","promethium-power-handling"},
    unit = {
        count = 1e9,
        ingredients = {
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "plasma-projector"
        }
    },
    order = "e-a",
    visible_when_disabled = true
}

-- Ion Cannon Technology --
local ion_cannon_tech = {
    type = "technology",
    name = "ion-cannon",
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/ion-cannon.png",
            icon_size = 256,
            mipmap_count = 4
        }
    },
    prerequisites = {"isotope-processing","promethium-weapons-tech","promethium-power-handling"},
    unit = {
        count = 1e9,
        ingredients = {
            {"promethium-science-pack", 1}
        },
        time = 30
    },
    effects = {
        { type = "unlock-recipe", recipe = "ion-cannon" },
        { type = "unlock-recipe", recipe = "ion-cannon-ammo" }
    },
    order = "e-c"
}

-- Extend Data
data:extend({
    promethium_processing,
    isotope_processing,
    promethium_space_travel,
    promethium_power_handling,
    plasma_projector_tech,
    promethium_weapons_tech,
    promethium_rocket_tech,
    ion_cannon_tech
})
