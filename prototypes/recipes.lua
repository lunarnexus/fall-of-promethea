local promethium_crusher_recipe = {
    type = "recipe",
    name = "promethium-gravel",
    category = "crushing",
    enabled = false,
    energy_required = 1,
    allow_productivity = true,
    show_amount_in_title = false,
    ingredients = {
        {type = "item", name = "promethium-asteroid-chunk", amount = 25}
    },
    results = {
        {type = "item", name = "promethium-gravel", amount = 12},
        {type = "item", name = "promethium-asteroid-chunk", amount = 1, probability = 0.2}
    },
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
    subgroup = "space-material",
    order = "b[promethium-gravel]"
}

local promethium_centrifuge_recipe = {
    type = "recipe",
    name = "promethium-ore",
    category = "centrifuging",
    enabled = false,
    energy_required = 4,
    allow_productivity = true,
    show_amount_in_title = false,
    ingredients = {
        {type = "item", name = "promethium-gravel", amount = 6}
    },
    results = {
        {type = "item", name = "promethium-ore", amount = 3},
        {type = "item", name = "iron-ore", amount = 3, probability = 0.2},
        {type = "item", name = "uranium-ore", amount = 1, probability = 0.1}
    },
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
    subgroup = "intermediate-product",
    order = "d[promethium-ore]"
}

local promethium_smelting_recipe = {
    type = "recipe",
    name = "promethium-plate",
    category = "metallurgy",
    enabled = false,
    energy_required = 4,
    allow_productivity = true,
    show_amount_in_title = false,
    result_is_always_fresh = true,
    ingredients = {
        {type = "item", name = "promethium-ore", amount = 12},
        {type = "item", name = "calcite", amount = 1}  
    },
    results = {
        {type = "item", name = "promethium-plate", amount = 4}
    },
    icons = {
        {
            icon = "__base__/graphics/icons/iron-plate.png",
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.5, a = 1},
            draw_as_light = true
        }
    },
    subgroup = "raw-material",
    order = "e[promethium-plate]"
}
-- EM Plant Recipe: Unstable Isotope
local emplant_isotope_recipe = {
    type = "recipe",
    name = "unstable-isotope",
    category = "electromagnetics",  
    enabled = false,
    energy_required = 0.5,  -- 0.5 second
    result_is_always_fresh = true,
    allow_productivity = true,
    show_amount_in_title = false,
    ingredients = {
        {type = "item", name = "promethium-plate", amount = 1},
        {type = "item", name = "copper-plate", amount = 1},
        {type = "item", name = "lithium-plate", amount = 1}
    },
    results = {
        {type = "item", name = "unstable-isotope", amount = 1, probability = 0.75},
        {type = "item", name = "promethium-plate", amount = 1, probability = 0.5},
        {type = "item", name = "stable-isotope", amount = 1, probability = 0.25},
        {type = "item", name = "lithium-plate", amount = 1, probability = 0.5}
    },
    icons = {
        {
            icon = "__fall-of-promethea__/graphics/icons/unstable-isotope.png",
            icon_size = 64,
            tint = {r = 1, g = 0.1, b = 0.1, a = 1}  -- Bright red tint for recipe icon
        }
    },
    subgroup = "intermediate-product",
    order = "f[unstable-isotope]"
}

-- Recycler Recipe: Stable Isotope
local recycle_stable_isotope = {
    type = "recipe",
    name = "stable-isotope-recycling",
    category = "recycling",
    enabled = false,
    hidden = true,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {
        {type = "item", name = "stable-isotope", amount = 1}
    },
    results = {
        {type = "item", name = "unstable-isotope", amount = 1, probability = 0.25}
    },
    icons = {
        -- Base icon (stable isotope)
        {
            icon = "__fall-of-promethea__/graphics/icons/unstable-isotope.png",
            icon_size = 64,
            tint = {r = 0.5, g = 0, b = 0, a = 1}  -- Dark red tint
        },
        -- Overlay recycling symbol
        {
            icon = "__quality__/graphics/icons/recycling.png",
            icon_size = 64,
            scale = 0.5,  -- Scaled down for overlay
            shift = {0, 0}
        }
    },
    subgroup = "intermediate-product",
    order = "g[stable-isotope-recycling]"
}

-- Promethium Wall Recipe Definition
local promethium_wall_recipe = {
    type = "recipe",
    name = "promethium-wall",
    auto_recycle = false,
    allow_productivity = false,
    show_amount_in_title = false,
    enabled = false,  -- Unlocked via Promethium Processing tech
    energy_required = 2,
    ingredients = {
        {type = "item", name = "stone-brick", amount = 5},
        {type = "item", name = "promethium-gravel", amount = 2}
    },
    results = {
        {type = "item", name = "promethium-wall", amount = 1}
    },
    icons = {
        {
            icon = "__base__/graphics/icons/wall.png",
            icon_size = 64,
        },
        {
            icon = "__base__/graphics/icons/wall.png",
            icon_size = 64,
            tint = {r = 1, g = 0.4, b = 0.5, a = 0.4}  -- Promethium red tint
        }
    },
    subgroup = "defensive-structure",
    order = "a[stone-wall]-b[promethium-wall]"
}

local promethium_thruster_recipe = {
    type = "recipe",
    name = "promethium-thruster",
    enabled = false,
    energy_required = 30,
    allow_productivity = false,
    show_amount_in_title = false,
    ingredients = {
        {type = "item", name = "electric-engine-unit", amount = 10},
        {type = "item", name = "unstable-isotope", amount = 20},
        {type = "item", name = "steel-plate", amount = 30},
        {type = "item", name = "processing-unit", amount = 15}
    },
    results = {
        {type = "item", name = "promethium-thruster", amount = 1}
    },
    icons = {
        {
            icon = "__space-age__/graphics/technology/space-platform-thruster.png",
            icon_size = 256,
            scale = 0.5
        },
        {
            icon = "__space-age__/graphics/technology/space-platform-thruster.png",
            icon_size = 256,
            scale = 0.5,
            tint = {r = 1, g = 0.4, b = 0.5, a = 0.1}  -- Promethium red tint
        }
    },
    subgroup = "space-platform",
    order = "f[promethium-thruster]"
}

-- Promethium Accumulator
local promethium_accumulator_recipe = {
    type = "recipe",
    name = "promethium-accumulator",
    enabled = false,
    category = "electronics",
    allow_productivity = false,
    show_amount_in_title = false,
    energy_required = 20,
    icons = {
        { icon = "__fall-of-promethea__/graphics/icons/accumulator.png", icon_size = 64 }
    },
    ingredients = {
        { type = "item", name = "carbon-fiber", amount = 5},
        { type = "item", name = "supercapacitor", amount = 10 },
        { type = "item", name = "battery", amount = 5 },
        { type = "item", name = "unstable-isotope", amount = 5 }
    },
    results = {
      { type = "item", name = "promethium-accumulator", amount = 1 }
    }
  }

local promethium_bcr_recipe = {
    type = "recipe",
    name = "promethium-bcr-panel",
    enabled = false,
    category = "electronics",
    energy_required = 20,
    allow_productivity = false,
    show_amount_in_title = false,
    ingredients = {
        {type = "item", name = "carbon-fiber", amount = 5},
        {type = "item", name = "superconductor", amount = 5},
        {type = "item", name = "unstable-isotope", amount = 5}
    },
    results = {
        {type = "item", name = "promethium-bcr-panel", amount = 1}
    }    
}

-- Recipe for Promethium Bullet Magazine
local promethium_bullet_recipe = {
    type = "recipe",
    name = "promethium-bullet-magazine",
    enabled = false,
    energy_required = 5,
    auto_recycle = false,
    allow_productivity = false,
    show_amount_in_title = false,
    -- result_is_always_fresh = true,
    ingredients = {
        {type = "item", name = "piercing-rounds-magazine", amount = 1},
        {type = "item", name = "explosives", amount = 1},
        {type = "item", name = "promethium-ore", amount = 1}
      },
    results = {
        {type = "item", name = "promethium-bullet-magazine", amount = 1}
    }
  }

-- Promethium Grenade Recipe
local promethium_grenade_recipe = table.deepcopy(data.raw["recipe"]["grenade"])
promethium_grenade_recipe.name = "promethium-grenade"
promethium_grenade_recipe.enabled = false
promethium_grenade_recipe.energy_required = 8
promethium_grenade_recipe.auto_recycle = false
promethium_grenade_recipe.allow_productivity = false
promethium_grenade_recipe.show_amount_in_title = false
-- promethium_grenade_recipe.result_is_always_fresh = true
promethium_grenade_recipe.ingredients = {
  { type = "item", name = "grenade", amount = 1 },
  { type = "item", name = "promethium-ore", amount = 2 }
}
promethium_grenade_recipe.results = {
  { type = "item", name = "promethium-grenade", amount = 1 }
}

-- Promethium Plasma Projector
local plasma_projector_recipe = {
    type = "recipe",
    name = "plasma-projector",
    enabled = false,
    auto_recycle = false,
    allow_productivity = false,
    show_amount_in_title = false,
    category = "electromagnetics",
    energy_required = 30,
    ingredients = {
        { type = "item", name = "teslagun", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 200 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "superconductor", amount = 100 },
        { type = "fluid", name = "electrolyte", amount = 500 },
        { type = "item", name = "unstable-isotope", amount = 15 }
    },
    results = {
        {type = "item", name = "plasma-projector", amount = 1}
    }
}

-- Promethium Rocket Recipe
local promethium_rocket_recipe = {
    type = "recipe",
    name = "promethium-rocket",
    category = "crafting",
    enabled = false, -- Unlocked by crafting 10 Promethium Grenades
    energy_required = 12, -- Longer crafting time due to advanced materials
    ingredients = {
        {type = "item", name = "rocket", amount = 1}, -- Base rocket
        {type = "item", name = "unstable-isotope", amount = 2}, -- Promethium for radiation payload
        {type = "item", name = "explosives", amount = 3} -- Extra radioactive material
    },
    results = {
        {type = "item", name = "promethium-rocket", amount = 1}
    },
    icons = {
        {
            icon = "__base__/graphics/icons/explosive-rocket.png",
            icon_size = 64,
        },
        {
            icon = "__base__/graphics/icons/explosive-rocket.png",
            icon_size = 64,
            tint = {r = 0.8, g = 0.2, b = 0.2, a = 0.7} -- Promethium red tint
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-c[promethium-rocket]"
}
-- Ion Cannon -- 
local ion_cannon_recipe = {
    type = "recipe",
    name = "ion-cannon",
    enabled = false,
    energy_required = 30,
    category = "electromagnetics",
    ingredients = {
        {type = "item", name = "plasma-projector", amount = 1},
        { type = "item", name = "artillery-turret", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 100 },
        {type = "item", name = "quantum-processor", amount = 100},
        { type = "item", name = "unstable-isotope", amount = 30 }
    },
    results = {
        {type = "item", name = "ion-cannon", amount = 1}
    }
}

local ion_cannon_ammo_recipe = {
    type = "recipe",
    name = "ion-cannon-ammo",
    enabled = false,
    energy_required = 8,
    category = "electromagnetics",
    ingredients = {
        {type = "item", name = "unstable-isotope", amount = 1},
        {type = "item", name = "fusion-power-cell", amount = 1},
        {type = "item", name = "quantum-processor", amount = 1}
    },
    results = {
        {type = "item", name = "ion-cannon-ammo", amount = 2}
    }
}

data:extend({
    promethium_crusher_recipe,
    promethium_centrifuge_recipe,
    promethium_smelting_recipe,
    emplant_isotope_recipe,
    recycle_stable_isotope,
    promethium_wall_recipe,
    promethium_thruster_recipe,
    promethium_accumulator_recipe,
    promethium_bcr_recipe,
    promethium_bullet_recipe,
    promethium_grenade_recipe,
    plasma_projector_recipe,
    promethium_rocket_recipe,
    ion_cannon_recipe,
    ion_cannon_ammo_recipe
})

