-- If enabled, add promethium asteroids to specific space-connections
  if settings.startup["enable-aquilo-promethium"] and settings.startup["enable-aquilo-promethium"].value then
    local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
  
    -- Modify the original planet and lane definitions
    asteroid_util.fulgora_ratio[4] = 0.0625
    asteroid_util.gleba_ratio[4] = 0.625
    asteroid_util.aquilo_ratio[4] = 0.125
    asteroid_util.system_edge_ratio[4] = 0.5

    local sse_lane = asteroid_util.aquilo_solar_system_edge
    sse_lane.has_promethium_asteroids = true
    sse_lane.type_ratios[2].ratios[4] = 0.25
    sse_lane.type_ratios[3].ratios[4] = 0.25
    sse_lane.type_ratios[4].ratios[4] = 0.25
    sse_lane.type_ratios[5].ratios[4] = 0.25
    sse_lane.type_ratios[6].ratios[4] = 0.25
    sse_lane.type_ratios[7].ratios[4] = 0.25
    sse_lane.type_ratios[8].ratios[4] = 0.25
    asteroid_util.fulgora_aquilo.has_promethium_asteroids = true
    asteroid_util.gleba_aquilo.has_promethium_asteroids = true
  
    -- Inject into the space-connection and planet prototypes
    data.raw["planet"]["aquilo"].asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.fulgora_aquilo, 0.9)
    data.raw["space-connection"]["gleba-aquilo"].asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.gleba_aquilo)
    data.raw["space-connection"]["fulgora-aquilo"].asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.fulgora_aquilo)
    data.raw["space-connection"]["aquilo-solar-system-edge"].asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge)
    data.raw["space-location"]["solar-system-edge"].asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge, 0.9)
  end
  