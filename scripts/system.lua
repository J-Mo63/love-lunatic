-- A module for system related methods and variables
local M = {}

to_console = "None"
-- Checks for any system commands
function M.update(dt)
  -- Make the application quit on command + w
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("w") then
    love.event.quit()
  end
function M.render()
  love.graphics.print(to_console, 0, 0)
end
 
return M