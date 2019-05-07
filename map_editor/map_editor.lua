-- A module for map related methods and variables
local M = {}

-- Module fields
local MENU_SCALE = 1.5

-- The currently selected tile
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
    M.game_map[y_tile][x_tile] = M.selected_tile
  end
end

-- Renders the editor menu to the screen
function M.render()
  local y_loc = 20
  local x_loc = 10
  local count = 0
  for i, tile_type in pairs(M.tiles) do
    for j, tile in pairs(tile_type) do
      love.graphics.draw(tile, x_loc, y_loc, 0, 
        M.map_config.tile_scale / M.map_config.TILE_DENSITY / MENU_SCALE)
      y_loc = y_loc + M.map_config.scaled_tile_height / MENU_SCALE
      count = count + 1
      if (count == 22) then
        y_loc = 20
        x_loc = x_loc + M.map_config.scaled_tile_height / MENU_SCALE
      end
    end
  end
end
 
return M