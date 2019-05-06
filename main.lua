-- Import the required system modules
local system = require("system")
local player = require("player")
local map = require("map")

function love.load()
  player.init()
  map.init()
end

function love.update(dt)
  system.update()
  player.update_movement(dt)
end

function love.draw()
  map.render()
  love.graphics.print("-_-", player.location.x, player.location.y, 0)
end