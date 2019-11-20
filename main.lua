-- Import the required modules
local system = require("scripts.system")
local player = require("scripts.player")
local map = require("scripts.map")
local map_loader = require("scripts.map_loader")
local scene = require("scripts.scene")

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Set window display settings
  love.window.setMode(love.graphics.getWidth(), 
    love.graphics.getHeight(), {fullscreen = false})

  -- Initialise modules for use
  player.init()
  map.init()
  scene.init("main", {x = 9, y = 9}, map_loader, map, player)
end

function love.update(dt)
  -- Register game updates
  system.update(dt)
  player.update(dt)
  scene.update(dt)

  -- if reset_map then
  --   map.setup_fields()
  --   reset_map = false
  -- end
end

function love.draw()
  -- Render game components on the screen
  map.render()
  player.render()
  system.render()
  scene.render()
end