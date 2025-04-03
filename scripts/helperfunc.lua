-- DEBUG mode toggle
local DEBUG = false

technology = require("scripts.technology")

local helperfunc = {}

--Function to check if all prerequisites of a technology are researched
function helperfunc.tech_prereqs_met(force, tech_name)
    local tech = force.technologies[tech_name]
    if not tech then return false end  -- If the tech doesn't exist, return false

    for _, prerequisite in pairs(tech.prerequisites or {}) do
        if not prerequisite.researched then
            return false  -- If any prerequisite is missing, return false
        end
    end

    return true  -- All prerequisites are researched
end

-- Calculate the platform's absolute travel distance using the space connection
function helperfunc.get_platform_distance(platform)
    if not platform.space_connection or not platform.space_connection.length then
        return 0  -- Fallback to prevent errors
    end
    return platform.distance * platform.space_connection.length  -- Get absolute distance in km
end

--[[ Check if a platform has traveled far enough towards the SP to unlock tech - 50,000km
function helperfunc.check_platform_distances_50k()
    local force = game.forces["player"]
    local ship_in_connection = false  -- Track if any ship is still in range

    for _, surface in pairs(game.surfaces) do
        local platform = surface.platform
        if platform and platform.valid and platform.space_connection and 
           platform.space_connection.name == "solar-system-edge-shattered-planet" then
            ship_in_connection = true  -- At least one ship is in the correct connection

            local travel_distance = helperfunc.get_platform_distance(platform)
            -- 50,000km past SSE
            local technology = force.technologies["promethium-rocket-tech"]
            -- Ensure storage entry exists for this platform, probably should happen in a migration script
            if not storage.progress_checks then
                storage.progress_checks = {}
            end
            if not storage.progress_checks[platform.name] then
                storage.progress_checks[platform.name] = { warned = false }
            end
            if travel_distance >= 50000 and not technology.researched then
                if helperfunc.tech_prereqs_met(force, "promethium-rocket-tech") then
                    force.technologies["promethium-rocket-tech"].researched = true
                    game.print({"","Promethean Rocket debris found. Reverse-engineering has uncovered:", "[img=technology/promethium-rocket-tech] ", {"technology-name.promethium-rocket-tech"}})
                    --force.add_tips_and_tricks_item("promethium-rocket-hint")
                else
                    if not storage.progress_checks[platform.name].warned then
                        game.print("You've found ancient Promethium Rocket debris, but lack the research to understand its secrets.")
                        storage.progress_checks[platform.name].warned = true
                    end
                end
            else
                storage.progress_checks[platform.name].warned = false
            end
        end
    end
    -- Reschedule if a ship is still in the zone
    if ship_in_connection then
        schedule_job(600, "helperfunc.check_platform_distances_50k")  -- Run every 10 seconds
    elseif DEBUG then
        game.print("[DEBUG] No ships in the shattered planet zone. Stopping distance checks.")
    end
end
]]

-- General function to check all distance-based tech unlocks
function helperfunc.check_platform_distances()
    local force = game.forces["player"]
    local ship_in_connection = false  
    local distance_multiplier = settings.startup["fop_tech_distance_multiplier"].value

    for _, surface in pairs(game.surfaces) do
        local platform = surface.platform
        if platform and platform.valid and platform.space_connection and 
           platform.space_connection.name == "solar-system-edge-shattered-planet" then
            ship_in_connection = true  

            local travel_distance = helperfunc.get_platform_distance(platform)

            for _, unlock in ipairs(technology.distance_tech_unlocks) do
                local tech = force.technologies[unlock.tech]

                -- Ensure storage entry exists
                if not storage.progress_checks then storage.progress_checks = {} end
                if not storage.progress_checks[platform.name] then
                    storage.progress_checks[platform.name] = { warned = {} }
                end
                if not storage.progress_checks[platform.name].warned then
                    storage.progress_checks[platform.name].warned = {}  -- Ensure it's a table
                end                

                -- Check if the distance requirement is met and the tech isn't unlocked, and the prerequisites are met
                local required_distance = unlock.distance * distance_multiplier
                if travel_distance >= required_distance and not tech.researched then
                    if helperfunc.tech_prereqs_met(force, unlock.tech) then
                        tech.researched = true
                        game.print({"", {"distance-tech-unlock." .. unlock.tech}, " [technology=" .. unlock.tech .. "]"})
                    else
                        if not storage.progress_checks[platform.name].warned[unlock.tech] then
                            game.print({"custom-messages.distance-tech-warning", " [technology=" .. unlock.tech .. "]"})
                            storage.progress_checks[platform.name].warned[unlock.tech] = true
                        end                        
                    end
                elseif storage.progress_checks[platform.name].warned[unlock.tech] then
                    storage.progress_checks[platform.name].warned[unlock.tech] = false
                end                
            end
        end
    end
    -- Reschedule if a ship is still in the zone
    if ship_in_connection then
        schedule_job(600, "helperfunc.check_platform_distances")  
    elseif DEBUG then
        game.print("[DEBUG] No ships in the shattered planet zone. Stopping distance checks.")
    end
end

return helperfunc