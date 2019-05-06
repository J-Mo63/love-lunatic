-- A module for player and player controller related methods and variables
local M = {}

local player_speed = 4

M.location = {
  x = 100,
  y = 100,
}

function M.init()
  M.location.x = love.graphics.getWidth()/2
  M.location.y = love.graphics.getHeight()/2
end

function M.update_movement(dt)
  -- Get movement profiles for input
  temp_x = 0
  temp_y = 0
  if love.keyboard.isDown("right") then
    temp_x = (dt * 100)
  end
  if love.keyboard.isDown("left") then
    temp_x = -(dt * 100)
  end
  if love.keyboard.isDown("down") then
    temp_y = (dt * 100)
  end
  if love.keyboard.isDown("up") then
    temp_y = -(dt * 100)
  end

  -- Normalise movement
  magnitude = math.sqrt(temp_x^2 + temp_y^2)
  if magnitude > 1 then
    M.location.x = M.location.x + (temp_x / magnitude) * player_speed
    M.location.y = M.location.y + (temp_y / magnitude) * player_speed
  end
end
 
return M