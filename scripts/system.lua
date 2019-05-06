-- A module for system related methods and variables
local M = {}

-- Checks for any system commands
function M.update(dt)
  -- Make the application quit on command + w
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("w") then
    love.event.quit()
  end
end
 
return M