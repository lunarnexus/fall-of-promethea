-- DEBUG mode toggle
local DEBUG = false

helperfunc = require("scripts.helperfunc")

-- Initialize storage table on game start
script.on_init(function()
    -- Check if storage already exists to prevent wiping stored data
    if not storage then
        storage = {}
    end
    -- Ensure each sub-table exists without overwriting saved data
    storage.on_tick = storage.on_tick or {}  -- Keeps scheduled jobs
    storage.powered_entities = storage.powered_entities or {}  -- Keeps thrusters & ion cannons
    storage.progress_checks = storage.progress_checks or {} -- Progress checks for travel distance to SP
end)

-- Job Handlers -- 
-- Function to schedule a future job
function schedule_job(delay, job, ...)
    if not game then return end 
    local execute_tick = game.tick + delay
    if not storage.on_tick then
        storage.on_tick = {}  -- Ensure storage.on_tick is initialized
    end
    if not storage.on_tick[execute_tick] then
        storage.on_tick[execute_tick] = { { name = job, args = table.pack(...) } }  
    else
        table.insert(storage.on_tick[execute_tick], { name = job, args = table.pack(...) })
    end
    if DEBUG then log("Scheduled job: " .. job .. " to execute at tick " .. execute_tick) end
end
-- On-tick handler to process queued jobs
local function on_tick(event)
    if not storage.on_tick then
        storage.on_tick = {}
        return
    end
    local jobs = storage.on_tick[event.tick]
    if not jobs then return end
    if DEBUG then log("Executing jobs for tick " .. event.tick) end
    for _, job in pairs(jobs) do
        local job_func = load("return " .. job.name)()
        --local job_func = _G[job.name]  
        if DEBUG then log("Attempting to execute: " .. tostring(job.name)) end -- Log function name
        if type(job_func) == "function" then
            job_func(table.unpack(job.args, 1, job.args.n))  --  function with arguments
            if DEBUG then log("Successfully executed: " .. job.name) end
        else
            log("ERROR: Function not found or invalid: " .. tostring(job.name))
        end
    end
    storage.on_tick[event.tick] = nil  
end
script.on_event(defines.events.on_tick, on_tick)
-- Schedule jobs with: schedule_job(240, "ship_manager.check_enemy_ship_defeat", surface, spawn_position)


-- Handle on_built of entities with hidden power draw
script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity or event.entity
    local entity_power_map = {
        ["promethium-thruster"] = "thruster-power-draw",
        ["ion-cannon"] = "ion-cannon-power-draw"
    }
    if entity_power_map[entity.name] then
        local surface = entity.surface
        local position = entity.position
        local hidden_power = surface.create_entity{
            name = entity_power_map[entity.name],
            position = position,
            force = entity.force
        }
        hidden_power.destructible = false
        -- Store the entity and its power draw in the shared storage table
        storage.powered_entities = storage.powered_entities or {}
        table.insert(storage.powered_entities, {
            entity = entity,
            power_draw = hidden_power
        })
    end
end)
-- Handle removal of Thrusters or Ion Cannons
script.on_event({
    defines.events.on_player_mined_entity, 
    defines.events.on_robot_mined_entity,
    defines.events.on_marked_for_deconstruction,
    defines.events.on_pre_player_mined_item  
}, function(event)
  entity = event.entity
    if entity.name == "promethium-thruster" or entity.name == "ion-cannon" then
        for i, data in pairs(storage.powered_entities or {}) do
            if data.entity == entity then
                -- Destroy associated power draw
                if data.power_draw and data.power_draw.valid then
                    data.power_draw.destroy()
                end
                -- Destroy hidden radiation source if present
                if data.radiation_source and data.radiation_source.valid then
                    data.radiation_source.destroy()
                    data.radiation_source = nil
                end
                table.remove(storage.powered_entities, i)
                break
            end
        end
    end
end)
-- Handle Thruster and Ion Canon power check
script.on_nth_tick(120, function()
    if not storage.powered_entities then
        storage.powered_entities = {}  -- Initialize if nil
        return
    end
    for _, data in pairs(storage.powered_entities) do
        local entity = data.entity
        local power_draw = data.power_draw
        if entity and entity.valid and power_draw and power_draw.valid then
            -- Check if buffer has enough energy
            local buffer = power_draw.energy
            if buffer < 50000 then  -- Adjust for balance
                if entity.active then
                    entity.active = false  -- Disable entity
                end
                -- Place hidden radiation source if not already present
                if not data.radiation_source or not data.radiation_source.valid then
                    local radiation_entity = entity.surface.create_entity{
                        name = "item-on-ground",
                        position = entity.position,
                        stack = {name = "hidden-radiation-source", count = 1}
                    }
                    data.radiation_source = radiation_entity
                    game.print("DEBUG: Placing radiation entity")
                end
            else  -- Power is sufficient
                if not entity.active then
                    entity.active = true  -- Enable entity
                end
                -- Remove hidden radiation source if present
                if data.radiation_source and data.radiation_source.valid then
                    data.radiation_source.destroy()
                    data.radiation_source = nil
                end
            end
        end
    end
end)
script.on_event(defines.events.on_entity_died, function(event)
    local entity = event.entity
    -- Entities that should explode on death
    local explosive_entities = {
        ["promethium-thruster"] = true,
        ["promethium-accumulator"] = true,
        ["promethium-bcr-panel"] = true,
        ["ion-cannon"] = true  
    }
    if entity and entity.valid and explosive_entities[entity.name] then
        -- Trigger explosion
        local success, err = pcall(function()
            entity.surface.create_entity({
                name = "promethium-explosion",
                position = entity.position,
                force = entity.force
            })
        end)
        -- Cleanup from storage for all powered entities
        for i, data in pairs(storage.powered_entities or {}) do
            if data.entity == entity then
                -- Destroy associated power draw
                if data.power_draw and data.power_draw.valid then
                    data.power_draw.destroy()
                end
                -- Destroy hidden radiation source if present
                if data.radiation_source and data.radiation_source.valid then
                    data.radiation_source.destroy()
                    data.radiation_source = nil
                end
                -- Remove from storage
                table.remove(storage.powered_entities, i)
                break
            end
        end
    end
end)

--  Event: Space Platform State Change
-- TODO: This can spawn multiple check_platform_distance chains if the ship switches direction while in the space_connection
script.on_event(defines.events.on_space_platform_changed_state, function(event)
    local platform = event.platform
    if platform and platform.valid and platform.space_connection and 
        platform.space_connection.name == "solar-system-edge-shattered-planet" then
        
        -- Ensure storage initialization
        if not storage.progress_checks then storage.progress_checks = {} end
        if not storage.progress_checks[platform.name] then storage.progress_checks[platform.name] = {} end
        
        if DEBUG then 
            game.print("[DEBUG] Platform entered solar-system-edge-shattered-planet. Scheduling distance checks.") 
        end
        
        -- Schedule the general tech unlock checker
        schedule_job(600, "helperfunc.check_platform_distances")
    end
end)



