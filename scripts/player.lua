-- A module for player and player controller related methods and variables
local M = {}

-- Module constants
local PLAYER_SPEED = 2
local PLAYER_SCALE = 1.4
local ANIMAION_SPEED = 10
local INTERACTION_OFFSET = 5

-- The player location
M.transform = {
  x, y,
  w, h,
}

-- A list of collidable object transforms in the map
M.collidable_objects = {}
M.tagged_objects = {}

-- The player sprites
local sprites = {
  walking_down = {},
  walking_up = {},
  walking_right = {},
  walking_left = {},
}

-- Other module fields
local is_idle = true
local current_animation = nil
local current_frame = 0
local frame_tick = 0
local actionable = false

-- Initialises the player module for use
function M.init()
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

  -- Set player starting location and size
  M.transform.x = love.graphics.getWidth()/2
  M.transform.y = love.graphics.getHeight()/2
  M.transform.w = current_animation[1]:getWidth() * PLAYER_SCALE
  M.transform.h = M.transform.w
end

-- Updates the player and input state
function M.update(dt)
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

  -- Normalise player's movement
  local magnitude = math.sqrt(temp_x^2 + temp_y^2)
  if magnitude > 1 then
    temp_x = M.transform.x + (temp_x / magnitude) * PLAYER_SPEED
    temp_y = M.transform.y + (temp_y / magnitude) * PLAYER_SPEED

    -- Check if the player collided with any collidable objects
    local player_object = {temp_x, temp_y, M.transform.w, M.transform.h}
    if M.items_collided(player_object, M.collidable_objects) then
      -- Check if either x or y was would work on their own
      player_object = {temp_x, M.transform.y, M.transform.w, M.transform.h}
      if M.items_collided(player_object, M.collidable_objects) then
        player_object = {M.transform.x, temp_y, M.transform.w, M.transform.h}
        if not M.items_collided(player_object, M.collidable_objects) then
          M.transform.y = temp_y
        end
      else
        M.transform.x = temp_x
      end
    else
      -- Set the movements to the transform if it didn't collide
      M.transform.x = temp_x
      M.transform.y = temp_y
    end
    is_idle = false
  else
    -- Set the player as idle
    is_idle = true
  end

  -- Check if the player collided with any tagged objects
  actionable = M.items_collided(
                  {M.transform.x - INTERACTION_OFFSET, 
                   M.transform.y - INTERACTION_OFFSET, 
                   M.transform.w + INTERACTION_OFFSET*2, 
                   M.transform.h + INTERACTION_OFFSET*2}, 
                   M.tagged_objects)

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
  if actionable then
    local text = "Press f"
    local font = love.graphics.getFont()
    local width = M.transform.x - (font:getWidth(text) / 2) + M.transform.w / 2
    love.graphics.print(text, width, M.transform.y + M.transform.h + 10)
  end

  -- Draw player hitbox to the screen
  if debug_mode then
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", M.transform.x, M.transform.y, M.transform.w, M.transform.h)
    love.graphics.setColor(255,255,255)
  end
end

-- A method to check if the player collides with any of a set of items
function M.items_collided(player, items)
  -- Check if the player collided with any items
  for i, item in ipairs(items) do
    if M.collided(player, item) then
      return true
    end
  end
  return false
end

-- A method to check whether two objects collide
function M.collided(object_a, object_b)
  return object_a[1] < object_b[1] + object_b[3] and
         object_b[1] < object_a[1] + object_a[3] and
         object_a[2] < object_b[2] + object_b[4] and
         object_b[2] < object_a[2] + object_a[4]
end
 
return M