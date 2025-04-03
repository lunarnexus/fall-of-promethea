require("util")

-- Base picture function for Promethium Accumulator
function promethium_accumulator_picture(tint, repeat_count)
  return {
    layers = {
      {
        filename = "__fall-of-promethea__/graphics/entity/accumulator.png", -- Your custom accumulator graphic
        priority = "high",
        width = 130,
        height = 189,
        repeat_count = repeat_count or 1,
        shift = util.by_pixel(0, -11),
        --tint = tint or {r = 1, g = 0.3, b = 0.4, a = 1},
        scale = 0.5
      },
      {
        filename = "__base__/graphics/entity/accumulator/accumulator-shadow.png", -- Using base shadow
        priority = "high",
        width = 234,
        height = 106,
        repeat_count = repeat_count or 1,
        shift = util.by_pixel(29, 6),
        draw_as_shadow = true,
        scale = 0.5
      }
    }
  }
end

-- Charge animation for accumulator
function promethium_accumulator_charge()
  return {
    layers = {
      promethium_accumulator_picture({r = 1, g = 1, b = 1, a = 0.5}, 24), -- Example tint during charging
      {
        filename = "__fall-of-promethea__/graphics/entity/accumulator-charge.png",
        priority = "high",
          width = 178,
          height = 210,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = {0, -0.6875},
          scale = 0.5
      }
    }
  }
end

-- Discharge animation for accumulator
function promethium_accumulator_discharge()
  return {
    layers = {
      promethium_accumulator_picture({r = 1, g = 1, b = 1, a = 0.5}, 24), -- Example tint during discharge
      {
      filename = "__fall-of-promethea__/graphics/entity/accumulator-discharge.png",
      priority = "high",
      width = 174,
      height = 214,
      line_length = 6,
      frame_count = 24,
      draw_as_glow = true,
      shift = {-0.03125, -0.71875},
      scale = 0.5  
      }
    }
  }
end

