-- A module for map related methods and variables
local M = {}

-- Module fields
local MENU_SCALE = 0.5
local MENU_Y = 20
local MENU_X = 0
local selected_tile = nil
local right_side = nil
local menu_tile_scale = nil
local menu_tile_height = nil
local menu_tile_col_max = nil

-- Imported fields
M.map_config = nil
M.tiles = nil
M.game_map = nil

-- Initialises the map editor module for use
function M.init()
  -- Initialise the default tile as selected
  selected_tile = M.tiles.system.placeholder

  -- Find the right side of the screen
  right_side = (M.map_config.scaled_tile_height 
    * M.map_config.TILE_DENSITY + M.map_config.letterboxing)

  -- Calculate menu sizing variables
  menu_tile_scale = M.map_config.tile_scale / M.map_config.TILE_DENSITY * MENU_SCALE
  menu_tile_height = selected_tile:getHeight() * menu_tile_scale
  menu_tile_col_max = math.floor((love.graphics.getHeight()-MENU_Y) / menu_tile_height)
end

-- Updates the editor input state
function M.update()
  -- Check if the mouse button is down
  if love.mouse.isDown(1) then
    -- Get the mouse position
    local x, y = love.mouse.getPosition()

    if x > M.map_config.letterboxing then
      -- Work out the x and y coordinates for the mouse in tiles
      local x_tile = math.floor(tonumber((x - M.map_config.letterboxing) / M.map_config.scaled_tile_height)) + 1
      local y_tile = math.floor(tonumber(y / M.map_config.scaled_tile_height)) + 1
      -- Update the selected tile with a sprite
      M.game_map[y_tile][x_tile] = selected_tile
    else
      -- Work out the x and y coordinates for the mouse in menu tiles
      local x_tile = math.floor(tonumber(x / menu_tile_height))
      local y_tile = math.floor(tonumber(y / menu_tile_height))
      -- Calculate the index and search for the tile
      local tile_index = y_tile + (x_tile * menu_tile_col_max)
      local count = 1
      for i, tile_type in pairs(M.tiles) do
        for j, tile in pairs(tile_type) do
          -- Check if it is the index tile to select
          if count == tile_index then
            selected_tile = tile
          end
          count = count + 1
        end
      end
    end
  end
end

-- Renders the editor menu to the screen
function M.render()
  -- Display the currently selected tile
  love.graphics.print("Selected:", right_side + 10, 10)
  love.graphics.draw(selected_tile, right_side + 10, 30, 0, menu_tile_scale)

  -- Draw the tile menu
  local x_loc = MENU_X
  local y_loc = MENU_Y
  local count = 0
  for i, tile_type in pairs(M.tiles) do
    for j, tile in pairs(tile_type) do
      -- Draw the tile to the menu
      love.graphics.draw(tile, x_loc, y_loc, 0, menu_tile_scale)
      -- Increment locational values
      y_loc = y_loc + M.map_config.scaled_tile_height * MENU_SCALE
      count = count + 1
      if (count == menu_tile_col_max) then
        -- Start a new column
        y_loc = MENU_Y
        x_loc = x_loc + M.map_config.scaled_tile_height * MENU_SCALE
        count = 0
      end
    end
  end
end
 
return M