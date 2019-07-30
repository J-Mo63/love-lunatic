-- A module for player and player controller related methods and variables
local M = {}

-- Module fields
local PLAYER_SPEED = 2
local PLAYER_SCALE = 1.4
local ANIMAION_SPEED = 10

-- The player location
M.transform = {
  x = 0,
  y = 0,
  h = 20,
  w = 20,
}

-- The player sprites
local sprites = {
  idle = {},
  walking = {},
}
local current_animation = nil
local current_frame = 0
local frame_tick = 0

-- Initialises the player module for use
function M.init()
  -- Set player starting location
  M.transform.x = love.graphics.getWidth()/2
  M.transform.y = love.graphics.getHeight()/2

  table.insert(sprites.idle, love.graphics.newImage("assets/char/player-centre.png"))
  table.insert(sprites.walking, love.graphics.newImage("assets/char/player-left.png"))
  table.insert(sprites.walking, love.graphics.newImage("assets/char/player-centre.png"))
  table.insert(sprites.walking, love.graphics.newImage("assets/char/player-right.png"))
  table.insert(sprites.walking, love.graphics.newImage("assets/char/player-centre.png"))

  current_animation = sprites.idle
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
    M.transform.x = M.transform.x + (temp_x / magnitude) * PLAYER_SPEED
    M.transform.y = M.transform.y + (temp_y / magnitude) * PLAYER_SPEED
  end

  -- Set the appropriate animation cycle
  if temp_x + temp_y == 0 then
    current_animation = sprites.idle
  else
    current_animation = sprites.walking
  end

  -- if M.check_collision(10, 10, 10, 10) then
  --   to_console = "collided!"
  -- else
  --   to_console = "no collided"
  -- end

  -- Calculate the current frame tick
  if frame_tick >= ANIMAION_SPEED then
    current_frame = current_frame + 1
    frame_tick = 0
  end
  frame_tick = frame_tick + 1
end

-- Renders the player sprite to the screen
function M.render()
  love.graphics.draw(current_animation[math.fmod(current_frame, table.getn(current_animation)) + 1], M.transform.x, M.transform.y, 0, PLAYER_SCALE)
end

--
function M.check_collision(x,y,w,h)
  return M.transform.x < x + w and
         x < M.transform.x + M.transform.w and
         M.transform.y < y + h and
         y < M.transform.y + M.transform.h
end
 
return M