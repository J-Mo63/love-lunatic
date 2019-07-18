-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")
local map_loader = require("scripts.map_loader")

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Initialise modules for use
  player.init()
  map.init()
  map_loader.init("main", map)
end

function love.update(dt)
  -- Register game updates
  system.update()
  player.update_movement(dt)
end

function love.draw()
  -- Render game components on the screen
  map.render()
  player.render()
  system.render()
end