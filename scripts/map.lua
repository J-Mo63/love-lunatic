-- A module for map related methods and variables
local M = {}

-- Map configuration values
M.map_config = {
  TILE_DENSITY = 16,
  tile_scale = nil,
  scaled_tile_height = nil,
  letterboxing = nil,
}

-- A list of M.tiles used in the game
M.tiles = {
  system = {},
  grass = {},
}

-- The ingame map to be displayed
M.game_map = {}

-- Registers all tile types to the tiles table
local function load_tiles()
  M.tiles.system.placeholder = love.graphics.newImage("assets/tiles/placeholder.png")
  M.tiles.grass.centre = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.bottom = love.graphics.newImage("assets/tiles/grass-bottom.png")
  M.tiles.grass.top = love.graphics.newImage("assets/tiles/grass-top.png")
  M.tiles.grass.left = love.graphics.newImage("assets/tiles/grass-left.png")
  M.tiles.grass.right = love.graphics.newImage("assets/tiles/grass-right.png")
  M.tiles.grass.topLeft = love.graphics.newImage("assets/tiles/grass-top-left.png")
end

-- Generates an empty game map to start
local function generate_map()
  for i = 1, M.map_config.TILE_DENSITY do
    table.insert(M.game_map, {})
  end
end

-- Initialises the map module for use
function M.init()
  -- Load the M.tiles
  load_tiles()

  -- Get the height of the imported tileset
  local tileset_height = M.tiles.grass.centre:getWidth()
  
  -- Get the screen dimensions
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()

  -- Get the tile-scaling variables
  M.map_config.tile_scale = screen_height / tileset_height
  M.map_config.scaled_tile_height = tileset_height * M.map_config.tile_scale / M.map_config.TILE_DENSITY

  -- Calculate the M.map_config.letterboxing offset
  M.map_config.letterboxing = (screen_width - screen_height)/2

  -- Load the game map
  generate_map()
end

-- Renders the game map to the screen using tiles
function M.render()
  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = M.map_config.letterboxing
    for j = 1, M.map_config.TILE_DENSITY do
      -- Check if the tile exists in the map
      tile = M.tiles.system.placeholder
      if M.game_map[i] and M.game_map[i][j] then
        tile = M.game_map[i][j]
      end
      -- Render it to the screen
      love.graphics.draw(tile, x_loc, y_loc, 0, M.map_config.tile_scale / M.map_config.TILE_DENSITY)
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    y_loc = y_loc + M.map_config.scaled_tile_height
  end
end
 
return M