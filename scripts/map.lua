-- A module for map related methods and variables
local M = {}

-- Module fields
local TILE_DENSITY = 16
local tile_scale = nil
local scaled_tile_height = nil
local letterboxing = nil

-- A list of tiles used in the game
local tiles = {
  system = {},
  grass = {},
}

-- The ingame map to be displayed
local game_map = nil

-- Registers all tile types to the tiles table
local function load_tiles()
  tiles.system.placeholder = love.graphics.newImage("/assets/tiles/placeholder.png")
  tiles.grass.centre = love.graphics.newImage("/assets/tiles/grass-centre.png")
  tiles.grass.bottom = love.graphics.newImage("/assets/tiles/grass-bottom.png")
  tiles.grass.top = love.graphics.newImage("/assets/tiles/grass-top.png")
  tiles.grass.left = love.graphics.newImage("/assets/tiles/grass-left.png")
  tiles.grass.right = love.graphics.newImage("/assets/tiles/grass-right.png")
  tiles.grass.topLeft = love.graphics.newImage("/assets/tiles/grass-top-left.png")
end

-- Initialises the map module for use
function M.init()
  -- Load the tiles
  load_tiles()

  -- Get the height of the imported tileset
  local tileset_height = tiles.grass.centre:getWidth()
  
  -- Get the screen dimensions
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()

  -- Get the tile-scaling variables
  tile_scale = screen_height/tileset_height
  scaled_tile_height = tileset_height*tile_scale/TILE_DENSITY

  -- Calculate the letterboxing offset
  letterboxing = (screen_width-screen_height)/2

  -- Load the game map
  game_map = {
    {tiles.grass.topLeft, tiles.grass.top, tiles.grass.top, tiles.grass.top},
    {tiles.grass.left, tiles.grass.centre, tiles.grass.centre, tiles.grass.centre},
  }
end

-- Renders the game map to the screen using tiles
function M.render()
  local y_loc = 0
  for i=1, TILE_DENSITY do
    local x_loc = letterboxing
    for j=1, TILE_DENSITY do
      -- Check if the tile exists in the map
      tile = tiles.system.placeholder
      if game_map[i] and game_map[i][j] then
        tile = game_map[i][j]
      end
      -- Render it to the screen
      love.graphics.draw(tile, x_loc, y_loc, 0, tile_scale/TILE_DENSITY)
      x_loc = x_loc + scaled_tile_height
    end
    y_loc = y_loc + scaled_tile_height
  end
end
 
return M