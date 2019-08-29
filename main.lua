-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")
local map_loader = require("scripts.map_loader")
local action = require("scripts.action")

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Initialise modules for use
  player.init()
  map.init()
  map_loader.init("main", map)
  player.collidable_objects = map.get_collidable_objects()
  player.tagged_objects = map.get_tagged_objects()
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
end