data:extend({

    -- Fall of Promethea (Main Introduction Tip)
    {
        type = "tips-and-tricks-item",
        name = "fall-of-promethea",
        category = "space-age",
        order = "p-a",
        is_title = true,
        tag = "[space-location=shattered-planet]",
        trigger = {
            type = "time-elapsed",
            ticks = 1 -- Unlocks immediately upon game start
        },
        image = "__fall-of-promethea__/graphics/tips/fop-1.png"
    },
    {
        type = "tips-and-tricks-item",
        name = "promethium-radiation",
        category = "space-age",
        order = "p-b",
        is_title = false,
        tag = "[img=item/promethium-ore]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "promethium-processing"
        },
        image = "__fall-of-promethea__/graphics/tips/process-tip.png",
        dependencies = { "fall-of-promethea" }
    },
    {
        type = "tips-and-tricks-item",
        name = "unstable-dangers",
        category = "space-age",
        order = "p-c",
        is_title = false,
        tag = "[img=item/unstable-isotope]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "isotope-processing"
        },
        image = "__fall-of-promethea__/graphics/tips/unstable-tip.png",
        dependencies = { "promethium-radiation" }
    },
    {
        type = "tips-and-tricks-item",
        name = "promethean-space-travel",
        category = "space-age",
        order = "p-d",
        is_title = false,
        tag = "[img=technology/promethium-space-travel]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "promethium-space-travel"
        },
        image = "__fall-of-promethea__/graphics/tips/power-tip.png",
        dependencies = { "unstable-dangers" }
    },
    {
        type = "tips-and-tricks-item",
        name = "promethium-energy",
        category = "space-age",
        order = "p-e",
        is_title = false,
        tag = "[img=technology/promethium-power-handling]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "promethium-power-handling"
        },
        image = "__fall-of-promethea__/graphics/tips/energy-tip.png",
        dependencies = { "promethean-space-travel" }
    },
    {
        type = "tips-and-tricks-item",
        name = "promethean-warfare",
        category = "space-age",
        order = "p-f",
        is_title = false,
        tag = "[img=technology/promethium-weapons-tech]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "promethium-weapons-tech"
        },
        image = "__fall-of-promethea__/graphics/tips/plasma-tip.png",
        dependencies = { "promethium-energy" }
    },
    {
        type = "tips-and-tricks-item",
        name = "promethium-rockets",
        category = "space-age",
        order = "p-g",
        is_title = false,
        tag = "[img=technology/promethium-rocket-tech]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "promethium-rocket-tech"
        },
        image = "__fall-of-promethea__/graphics/tips/promethium-rocket.png",
        dependencies = { "promethean-warfare" }
    },
    {
        type = "tips-and-tricks-item",
        name = "the-oath",
        category = "space-age",
        order = "p-h",
        is_title = false,
        tag = "[img=technology/ion-cannon]",
        indent = 1,  
        trigger = {
            type = "research",
            technology = "ion-cannon"
        },
        image = "__fall-of-promethea__/graphics/tips/the-oath.png",
        dependencies = { "promethium-rockets" }
    }
})
