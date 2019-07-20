-- A module for system related methods and variables
local M = {}

-- Module Fields
local display_fps = false

-- Globals
to_console = "Console ready"

-- Checks for any system commands
function M.update(dt)
  -- Make the application quit on command + w
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("w") then
    love.event.quit()
  end

  -- Make the application display FPS on command + f
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("f") then
    display_fps = true
  end

  -- Check if FPS should be displayed
  if display_fps then
    to_console = tostring(love.timer.getFPS())
  end
end

-- Renders UI to the screen
function M.render()
  love.graphics.print(to_console, 5, 2)
end
 
return M