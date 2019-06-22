-- A module for map related methods and variables
local M = {}

-- Map configuration values
M.map_config = {
  TILE_DENSITY = 16,
  LAYER_1_KEY = 1,
  LAYER_2_KEY = 2,
  TAG_KEY = 3,
  tile_scale = nil,
  scaled_tile_height = nil,
  letterboxing = nil,
}

-- A list of tiles used in the game
M.tiles = {}

-- The ingame map to be displayed
M.game_map = {}

-- Registers all tile types to the tiles table
local function load_tiles()
  M.tiles.placeholder = love.graphics.newImage("assets/tiles/placeholder.png")
  M.tiles.transparent = love.graphics.newImage("assets/tiles/transparent.png")
  M.tiles.grass_centre = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass_bottom = love.graphics.newImage("assets/tiles/grass-bottom.png")
  M.tiles.grass_top = love.graphics.newImage("assets/tiles/grass-top.png")
  M.tiles.grass_left = love.graphics.newImage("assets/tiles/grass-left.png")
  M.tiles.grass_right = love.graphics.newImage("assets/tiles/grass-right.png")
  M.tiles.grass_topLeft = love.graphics.newImage("assets/tiles/grass-top-left.png")
  M.tiles.bush = love.graphics.newImage("assets/tiles/bush.png")
  M.tiles.fence = love.graphics.newImage("assets/tiles/fence.png")
end

-- Generates an empty game map to start
local function load_map()
  for i = 1, M.map_config.TILE_DENSITY do
    local row = {}
    for i = 1, M.map_config.TILE_DENSITY do
      table.insert(row, {})
    end
    table.insert(M.game_map, row)
  end
end

-- Initialises the map module for use
function M.init()
  -- Load the M.tiles
  load_tiles()

  -- Get the height of the imported tileset
  local tileset_height = M.tiles.grass_centre:getWidth()
  
  -- Get the screen dimensions
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()

  -- Get the tile-scaling variables
  M.map_config.tile_scale = screen_height / tileset_height
  M.map_config.scaled_tile_height = tileset_height * M.map_config.tile_scale / M.map_config.TILE_DENSITY

  -- Calculate the M.map_config.letterboxing offset
  M.map_config.letterboxing = (screen_width - screen_height)/2

  -- Load the game map
  load_map()
end

-- Renders the game map to the screen using tiles
function M.render()
  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = M.map_config.letterboxing
    for j = 1, M.map_config.TILE_DENSITY do
      -- Check if the tile exists in the map
      local tile1 = M.game_map[i][j][M.map_config.LAYER_1_KEY] or M.tiles.placeholder
      local tile2 = M.game_map[i][j][M.map_config.LAYER_2_KEY] or M.tiles.transparent
      -- Render it to the screen
      love.graphics.draw(tile1, x_loc, y_loc, 0, 
        M.map_config.tile_scale / M.map_config.TILE_DENSITY)
      love.graphics.draw(tile2, x_loc, y_loc, 0, 
        M.map_config.tile_scale / M.map_config.TILE_DENSITY)
      -- Increment the x location of the tile
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    -- Increment the y location of the tile
    y_loc = y_loc + M.map_config.scaled_tile_height
  end
end
 
return M