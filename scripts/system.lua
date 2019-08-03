-- A module for system related methods and variables
local M = {}

-- Globals
to_console = "Console ready"
debug_mode = false

-- Checks for any system commands
function M.update(dt)
  -- Make the application quit on command + w
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("w") then
    love.event.quit()
  end

  -- Make the application display FPS on command + f
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("d") then
    debug_mode = true
  end

  -- Check if FPS should be displayed
  if debug_mode then
    to_console = "fps: " .. tostring(love.timer.getFPS())
  end
end

-- Renders UI to the screen
function M.render()
  love.graphics.print(to_console, 5, 2)
end
 
return M