-- The module table
Module = {
  system = require("scripts.system"),
  player = require("scripts.player"),
  map = require("scripts.map"),
  map_loader = require("scripts.map_loader"),
  scene = require("scripts.scene"),
  action = require("scripts.action"),
}

function love.load()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Set window display settings
  love.window.setMode(love.graphics.getWidth(), 
    love.graphics.getHeight(), {fullscreen = false})

  -- Initialise modules for use
  Module.player.init()
  Module.map.init()
  Module.scene.init("main", {x = 9, y = 9})
end

function love.update(dt)
  -- Register game updates
  Module.system.update(dt)
  Module.player.update(dt)
  Module.scene.update(dt)
end

function love.draw()
  -- Render game components on the screen
  Module.map.render()
  Module.player.render()
  Module.system.render()
  Module.scene.render()
end