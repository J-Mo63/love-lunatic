-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Initialise modules for use
  player.init()
  map.init()
end

function love.update(dt)
  -- Register game updates
  system.update()
  player.update_movement(dt)
  map.update()
end

function love.draw()
  -- Render game components on the screen
  map.render()
  player.render()
  system.render()
end