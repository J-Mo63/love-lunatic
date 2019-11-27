-- A module for object inspection related methods and variables
local M = {}

-- Module fields
M.display_inspector = false
M.image = nil

function M.inspect_object(image)
  M.image = love.graphics.newImage(image)
  Module.system.control_override = true
  M.display_inspector = true
  Module.system.key_bindings.f = M.close_inspector
end

function M.close_inspector()
  M.display_inspector = false
  Module.system.control_override = false
  Module.system.reset_key_bindings()
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