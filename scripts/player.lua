-- A module for player and player controller related methods and variables
local M = {}

-- Module fields
local PLAYER_SPEED = 4

-- The player location
M.location = {
  x = 100,
  y = 100,
}

-- Initialises the player module for use
function M.init()
  -- Set player starting location
  M.location.x = love.graphics.getWidth()/2
  M.location.y = love.graphics.getHeight()/2
end

-- Updates the player and input state
function M.update_movement(dt)
  -- Get movement profiles for input
  local temp_x = 0
  local temp_y = 0
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
  local magnitude = math.sqrt(temp_x^2 + temp_y^2)
  if magnitude > 1 then
    M.location.x = M.location.x + (temp_x / magnitude) * PLAYER_SPEED
    M.location.y = M.location.y + (temp_y / magnitude) * PLAYER_SPEED
  end
end

-- Renders the player sprite to the screen
function M.render()
  love.graphics.print("-_-", M.location.x, M.location.y, 0)
end
 
return M