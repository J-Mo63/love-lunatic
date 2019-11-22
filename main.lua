-- Initialise the module table
Module = {
  system = require("scripts.system"),
  player = require("scripts.player"),
  map = require("scripts.map"),
  map_loader = require("scripts.map_loader"),
  scene = require("scripts.scene"),
  action = require("scripts.action"),
  object_display = require("scripts.object_display")
}

function love.load()
  -- Initialise modules for use
  Module.system.init()
  Module.map.init()
  Module.player.init()
  Module.scene.init("main", {x = 9, y = 9})
end

function love.update(dt)
  -- Register game updates
  Module.system.update(dt)
  Module.player.update(dt)
  Module.scene.update(dt)
  Module.object_display.update(dt)
end

function love.draw()
  -- Render game components on the screen
  Module.map.render()
  Module.player.render()
  Module.system.render()
  Module.scene.render()
  Module.object_display.render()
end