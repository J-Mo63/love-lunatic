-- A module for object inspection related methods and variables
local M = {}

-- Module constants
local MAX_INTERACTION_COOLDOWN = 20

-- Module fields
M.display_inspector = false
M.image = nil

-- Module constants
local interaction_cooldown = MAX_INTERACTION_COOLDOWN

function M.inspect_object(image)
  M.image = love.graphics.newImage(image)
  Module.system.control_override = true
  M.display_inspector = true
end

function M.update(dt)
  if Module.system.control_override then
    if interaction_cooldown > 0 then
      interaction_cooldown = interaction_cooldown - 1
    elseif love.keyboard.isDown("f") then
      M.display_inspector = false
      Module.system.control_override = false
      interaction_cooldown = MAX_INTERACTION_COOLDOWN
    end
  end
end

function M.render()
  if M.display_inspector then
    local largest_image_dimension = (M.image:getWidth() >= M.image:getHeight() 
      and M.image:getWidth() or M.image:getHeight())
    local screen_height = love.graphics.getHeight()
    local scale_factor = (screen_height - 50) / largest_image_dimension
    love.graphics.draw(M.image, love.graphics.getWidth()/2 - M.image:getWidth()*scale_factor/2, 
      screen_height/2 - M.image:getHeight()*scale_factor/2, 0, scale_factor)

    Module.system.to_console = "press 'f' to close"
  end
end

return M