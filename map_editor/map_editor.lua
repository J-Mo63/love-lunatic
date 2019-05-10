-- A module for map related methods and variables
local M = {}

-- Module fields
local MENU_SCALE = 0.5
local selected_tile = nil
local menu_y = 20
local menu_x = 0

local menu_tile_scale = nil
local right_side = nil
local menu_tile_height = nil
local menu_tile_row_max = nil

-- Map configuration values
M.map_config = nil

-- A list of tiles used in the game
M.tiles = nil

-- The map to be edited
M.game_map = nil


function M.init()
  -- Initialise the default tile as selected
  selected_tile = M.tiles.system.placeholder

  -- Find the right side of the screen
  right_side = (M.map_config.scaled_tile_height 
    * M.map_config.TILE_DENSITY + M.map_config.letterboxing)

  -- Calculate menu sizing variables
  menu_tile_scale = M.map_config.tile_scale / M.map_config.TILE_DENSITY * MENU_SCALE
  menu_tile_height = selected_tile:getHeight() * menu_tile_scale
  menu_tile_row_max = math.floor((love.graphics.getHeight()-menu_y) / menu_tile_height)
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
      -- Work out the x and y coordinates for the mouse in tiles
      local x_tile = math.floor(tonumber(x / menu_tile_height))
      local y_tile = math.floor(tonumber(y / menu_tile_height))
      -- -- Update the selected tile with a sprite
      -- M.game_map[y_tile][x_tile] = selected_tile

      to_console = x_tile .. ":" .. y_tile
    end
  end
end

-- Renders the editor menu to the screen
function M.render()
  -- Display tile selection
  love.graphics.print("Selected:", right_side + 10, 10)
  love.graphics.draw(selected_tile, right_side + 10, 30, 0, menu_tile_scale)

  local x_loc = menu_x
  local y_loc = menu_y
  local count = 0
  for i, tile_type in pairs(M.tiles) do
    -- Hide all system tiles
    if i == "system" then return end
    for j, tile in pairs(tile_type) do
      -- Draw the tile to the menu
      love.graphics.draw(tile, x_loc, y_loc, 0, menu_tile_scale)
      -- Increment locational values
      y_loc = y_loc + M.map_config.scaled_tile_height * MENU_SCALE
      count = count + 1
      if (count == menu_tile_row_max) then
        -- Start a new column
        y_loc = menu_y
        x_loc = x_loc + M.map_config.scaled_tile_height * MENU_SCALE
        count = 0
      end
    end
  end
end
 
return M