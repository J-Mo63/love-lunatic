-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")
local map_loader = require("scripts.map_loader")
local action = require("scripts.action")

local alpha = 1
local fade_out = false
local fade_in = true
local current_map_name = nil
local player_start_location = nil

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Set window display settings
  love.window.setMode(love.graphics.getWidth(), 
    love.graphics.getHeight(), {fullscreen = false})
  -- Initialise modules for use
  player.init()
  map.init()
  setup_scene("main")
end

function love.update(dt)
  -- Register game updates
  system.update()
  player.update(dt)
end

function love.draw()
  -- Render game components on the screen
  map.render()
  player.render()
  system.render()

  if fade_out then
    alpha = alpha + 0.05
    if alpha >= 1 then
      fade_out = false
      setup_scene(current_map_name, player_start_location)
      fade_in = true
    end
  elseif fade_in then
    alpha = alpha - 0.05
    if alpha <= 0 then
      fade_in = false
    end
  end

  love.graphics.setColor(0, 0, 0, alpha)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.reset()
end

function change_scene(map_name, player_location)
  current_map_name = map_name
  player_start_location = player_location
  fade_out = true
end

-- A method to setup scenes with new maps and player locations
function setup_scene(map_name, player_location)
  -- Initialise the map in the map module
  map_loader.init(map_name, map)
  -- Update the player module fields with map data
  player.collidable_objects = map.get_collidable_objects()
  player.tagged_objects = map.get_tagged_objects()
  player.action_module = action
  -- Change player location if supplied
  if player_location then
    player.set_position(map.to_tile_location(player_location))
  end
end