-- A module for map related methods and variables
local M = {}

-- Module fields
M.selected_tile = nil

-- Map configuration values
M.map_config = nil

-- A list of tiles used in the game
M.tiles = nil

-- The map to be edited
M.game_map = nil

-- Updates the editor input state
function M.update()
  -- Check if the mouse button is down
  if love.mouse.isDown(1) then
    -- Get the mouse position
    local x, y = love.mouse.getPosition()
    -- Work out the x and y coordinates for the mouse in tiles
    local x_tile = math.floor(tonumber((x - M.map_config.letterboxing) / M.map_config.scaled_tile_height)) + 1
    local y_tile = math.floor(tonumber(y / M.map_config.scaled_tile_height)) + 1
    -- Update the selected tile with a sprite
    M.game_map[y_tile][x_tile] = M.tiles.grass.centre
  end
end

-- Renders the editor menu to the screen
function M.render()
  to_console = "test"
end
 
return M