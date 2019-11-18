-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")
local map_loader = require("scripts.map_loader")
local action = require("scripts.action")

local alpha = 0
local fade_out = false
local fade_in = true

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
  if fade_out then
    alpha = alpha - 0.1
    if alpha <= 0 then
      fade_out = false
      fade_in = true
    end
  elseif fade_in then
    alpha = alpha + 0.1
    if alpha >= 1 then
      fade_in = false
    end
  end
  love.graphics.setColor(255, 255, 255, alpha)

  -- Render game components on the screen
  map.render()
  player.render()
  system.render()
end

-- A method to setup scenes with new maps and player locations
function setup_scene(map_name, player_location)
  fade_out = true
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