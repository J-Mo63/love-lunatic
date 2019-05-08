-- A module for map related methods and variables
local M = {}

-- Module fields
local MENU_SCALE = 1.5

-- The currently selected tile
local selected_tile = nil

-- Map configuration values
M.map_config = nil

-- A list of tiles used in the game
M.tiles = nil

-- The map to be edited
M.game_map = nil

-- Updates the editor input state
function M.update()


  selected_tile = M.tiles.grass.centre



  -- Check if the mouse button is down
  if love.mouse.isDown(1) then
    -- Get the mouse position
    local x, y = love.mouse.getPosition()
    -- Work out the x and y coordinates for the mouse in tiles
    local x_tile = math.floor(tonumber((x - M.map_config.letterboxing) / M.map_config.scaled_tile_height)) + 1
    local y_tile = math.floor(tonumber(y / M.map_config.scaled_tile_height)) + 1
    -- Update the selected tile with a sprite
    M.game_map[y_tile][x_tile] = selected_tile
  end
end

-- Renders the editor menu to the screen
function M.render()
  -- Calculate menu variables
  local right_side = M.map_config.scaled_tile_height * M.map_config.TILE_DENSITY + M.map_config.letterboxing
  local menu_tile_size = M.map_config.tile_scale / M.map_config.TILE_DENSITY / MENU_SCALE

  -- Display tile selection
  love.graphics.print("Selected:", right_side + 10, 10)
  love.graphics.draw(selected_tile, right_side + 10, 30, 0, menu_tile_size)

  local y_loc = 20
  local x_loc = 10
  local count = 0
  for i, tile_type in pairs(M.tiles) do
    -- Hide all system tiles
    if i == "system" then return end
    for j, tile in pairs(tile_type) do
      -- Draw the tile to the menu
      love.graphics.draw(tile, x_loc, y_loc, 0, menu_tile_size)
      -- Increment locational values
      y_loc = y_loc + M.map_config.scaled_tile_height / MENU_SCALE
      count = count + 1
      if (count == 22) then
        -- Start a new column
        y_loc = 20
        x_loc = x_loc + M.map_config.scaled_tile_height / MENU_SCALE
      end
    end
  end
end
 
return M