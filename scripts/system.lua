-- A module for system related methods and variables
local M = {}

-- Globals
to_console = "Console ready"
debug_mode = false

-- Checks for any system commands
function M.update(dt)
  -- Define command functions
  if love.keyboard.isDown("lgui") then
    -- Make the application quit on command + w
    if love.keyboard.isDown("w") then
      love.event.quit()
    end
    
    -- Make the application enter debug mode on command + d
    if love.keyboard.isDown("d") then
      debug_mode = true
    end

    -- Make the application go into fullscreen mode on command + f
    if love.keyboard.isDown("f") then
      -- Toggle fullscreen option
      love.window.setFullscreen(not love.window.getFullscreen())
      -- Reset map drawing parameters
      Module.map.setup_map()
      -- Update collision and tagged object locations in the scene
      Module.player.collidable_objects = Module.map.get_collidable_objects()
      Module.player.tagged_objects = Module.map.get_tagged_objects()
    end
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