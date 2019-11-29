-- A module for system related methods and variables
local M = {}

-- Module Fields
local current_map_name = nil
local player_start_location = nil
local alpha = 1
local fade_out = false
local fade_in = false

-- Initialises the map module for use
function M.init(map_name, player_location)
  current_map_name = map_name
  player_start_location = player_location

  fade_in = true
  M.setup_scene()
end

-- Checks for any system commands
function M.update(dt)
  if fade_out then
    alpha = alpha + 0.05
    if alpha >= 1 then
      fade_out = false
      M.setup_scene()
      fade_in = true
    end
  elseif fade_in then
    alpha = alpha - 0.05
    if alpha <= 0 then
      fade_in = false
    end
  end
end

-- Renders UI to the screen
function M.render()
  love.graphics.setColor(0, 0, 0, alpha)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.reset()
end

function M.change_scene(map_name, player_location)
  current_map_name = map_name
  player_start_location = player_location
  fade_out = true
end

-- A method to setup scenes with new maps and player locations
function M.setup_scene()
  -- Initialise the map in the map module
  Module.map_loader.init(current_map_name, Module.map)
  -- Update the player module fields with map data
  Module.player.collidable_objects = Module.map.get_collidable_objects()
  Module.player.tagged_objects = Module.map.get_tagged_objects()
  -- Change player location
  Module.player.set_position(Module.map.to_tile_location(player_start_location, true))
end
 
return M