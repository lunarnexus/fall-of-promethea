-- Distance based tech unlock table -- 

local technology = {}

-- Distance-based tech unlocks
technology.distance_tech_unlocks = {
    { distance = 50000, tech = "promethium-rocket-tech", message_key = "distance-tech-unlock.promethium-rocket-tech" },
    { distance = 100000, tech = "plasma-projector-tech", message_key = "distance-tech-unlock.plasma-projector-tech" },
    { distance = 200000, tech = "ion-cannon", message_key = "distance-tech-unlock.ion-cannon" }
}

return technology
