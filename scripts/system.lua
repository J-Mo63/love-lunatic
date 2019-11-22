-- A module for system related methods and variables
local M = {}

-- Public module fields
M.to_console = "Console ready"
M.debug_mode = false
M.control_override = false

-- Initialises the game window and system features
function M.init()
  -- Set the window title
  love.window.setTitle("Unknowable Adventure")
  -- Set window display settings
  love.window.setMode(love.graphics.getWidth(), 
    love.graphics.getHeight(), {fullscreen = false})
end

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
      M.debug_mode = true
    end

    -- Make the application go into fullscreen mode on command + f
    if love.keyboard.isDown("f") then
      -- Collect old screen data
      local old_scale = Module.map.map_config.tile_scale
      local old_letterboxing = Module.map.map_config.letterboxing
      -- Toggle fullscreen option
      love.window.setFullscreen(not love.window.getFullscreen())
      -- Reset map and player drawing parameters
      Module.map.setup_map()
      Module.player.setup_player()
      -- Update collision and tagged object locations in the scene
      Module.player.collidable_objects = Module.map.get_collidable_objects()
      Module.player.tagged_objects = Module.map.get_tagged_objects()
      -- Update player position based on scale changes
      local scale_change = ((Module.map.map_config.tile_scale - old_scale) / old_scale) + 1
      Module.player.transform.x = ((Module.player.transform.x - old_letterboxing) * scale_change) 
      + Module.map.map_config.letterboxing
      Module.player.transform.y = Module.player.transform.y * scale_change
    end
  end

  -- Check if FPS should be displayed
  if M.debug_mode then
    M.to_console = "fps: " .. tostring(love.timer.getFPS())
  end
end

-- Renders UI to the screen
function M.render()
  love.graphics.print(M.to_console, 5, 2)
end
 
return M