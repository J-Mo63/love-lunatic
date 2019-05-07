-- Import the required modules
local system = require("scripts.system")
local map = require("scripts.map")
local editor = require("map_editor")

function love.load()
  -- Set the window title
  love.window.setTitle("Map Editor")
  -- Initialise modules for use
  map.init()
end

function love.update(dt)
  -- Register game updates
  system.update()
  map.update()
end

function love.draw()
  -- Render game components on the screen
  map.render()
  system.render()
end