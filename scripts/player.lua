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
  walking_down = {},
  walking_up = {},
  walking_right = {},
  walking_left = {},
}
local is_idle = true
local current_animation = nil
local current_frame = 0
local frame_tick = 0

-- Initialises the player module for use
function M.init()
  -- Set player starting location
  M.transform.x = love.graphics.getWidth()/2
  M.transform.y = love.graphics.getHeight()/2

  -- Import walking down animation
  table.insert(sprites.walking_down, 
    love.graphics.newImage("assets/char/player-idle-down.png"))
  table.insert(sprites.walking_down, 
    love.graphics.newImage("assets/char/player-walking-down-1.png"))
  table.insert(sprites.walking_down, 
    love.graphics.newImage("assets/char/player-idle-down.png"))
  table.insert(sprites.walking_down, 
    love.graphics.newImage("assets/char/player-walking-down-2.png"))

  -- Import walking up animation
  table.insert(sprites.walking_up, 
    love.graphics.newImage("assets/char/player-idle-up.png"))
  table.insert(sprites.walking_up, 
    love.graphics.newImage("assets/char/player-walking-up-1.png"))
  table.insert(sprites.walking_up, 
    love.graphics.newImage("assets/char/player-idle-up.png"))
  table.insert(sprites.walking_up, 
    love.graphics.newImage("assets/char/player-walking-up-2.png"))

  -- Import walking right animation
  table.insert(sprites.walking_right, 
    love.graphics.newImage("assets/char/player-idle-right.png"))
  table.insert(sprites.walking_right, 
    love.graphics.newImage("assets/char/player-walking-right-1.png"))
  table.insert(sprites.walking_right, 
    love.graphics.newImage("assets/char/player-idle-right.png"))
  table.insert(sprites.walking_right, 
    love.graphics.newImage("assets/char/player-walking-right-2.png"))

  -- Import walking left animation
  table.insert(sprites.walking_left, 
    love.graphics.newImage("assets/char/player-idle-left.png"))
  table.insert(sprites.walking_left, 
    love.graphics.newImage("assets/char/player-walking-left-1.png"))
  table.insert(sprites.walking_left, 
    love.graphics.newImage("assets/char/player-idle-left.png"))
  table.insert(sprites.walking_left, 
    love.graphics.newImage("assets/char/player-walking-left-2.png"))

  -- Set the default animation
  current_animation = sprites.walking_down
end

-- Updates the player and input state
function M.update_movement(dt)
  -- Get movement profiles for input
  local temp_x = 0
  local temp_y = 0
  if love.keyboard.isDown("right") then
    temp_x = (dt * 100)
    current_animation = sprites.walking_right
  end
  if love.keyboard.isDown("left") then
    temp_x = -(dt * 100)
    current_animation = sprites.walking_left
  end
  if love.keyboard.isDown("down") then
    temp_y = (dt * 100)
    current_animation = sprites.walking_down
  end
  if love.keyboard.isDown("up") then
    temp_y = -(dt * 100)
    current_animation = sprites.walking_up
  end

  -- Normalise movement
  local magnitude = math.sqrt(temp_x^2 + temp_y^2)
  if magnitude > 1 then
    M.transform.x = M.transform.x + (temp_x / magnitude) * PLAYER_SPEED
    M.transform.y = M.transform.y + (temp_y / magnitude) * PLAYER_SPEED
  end

  -- Set the player as idle
  if temp_x + temp_y == 0 then
    is_idle = true
  else
    is_idle = false
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
  -- Check whether the player is idle
  local frame_num = 1
  if not is_idle then
    -- Get the current frame for the animation
    frame_num = math.fmod(current_frame, table.getn(current_animation)) + 1
  end

  -- Draw the current player sprite animation to the screen
  love.graphics.draw(current_animation[frame_num], M.transform.x, M.transform.y, 0, PLAYER_SCALE)
end

-- A method to check whether the player is colliding with a set of coordinates
function M.check_collision(x,y,w,h)
  return M.transform.x < x + w and
         x < M.transform.x + M.transform.w and
         M.transform.y < y + h and
         y < M.transform.y + M.transform.h
end
 
return M