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
  M.tiles.grass.centre1 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre12 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre13 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre4 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre5 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre6 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre15 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre125 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre136 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre74 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre58 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.centre68 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre1 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre12 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre13 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre4 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre5 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre6 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre15 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre125 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre136 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre74 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre58 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre68 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre5 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1e3ntre6 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entr3e15 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1e3ntre125 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1entre136 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1ent3re74 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1e3ntre58 = love.graphics.newImage("assets/tiles/grass-centre.png")
  M.tiles.grass.c1en3tre68 = love.graphics.newImage("assets/tiles/grass-centre.png")
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