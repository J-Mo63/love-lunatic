-- A module for map related methods and variables
local M = {}

-- Module fields
local tileDesity = 16
local tileHeight = nil
local tileScale = nil

-- A list of tiles used in the game
local tiles = {
  grass = {},
}

-- The ingame map to be displayed
local game_map = nil

-- Registers all tile types to the tiles table
local function load_tiles()
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
  tilesetHeight = tiles.grass.centre:getWidth()
  
  -- Get the screen dimensions
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  -- Get the tile-scaling variables
  tileScale = screenHeight/tilesetHeight
  scaledTileHeight = tilesetHeight*tileScale/tileDesity

  -- Calculate the letterboxing offset
  letterboxing = (screenWidth-screenHeight)/2

  -- Load the game map
  game_map = {
    {tiles.grass.topLeft, tiles.grass.top, tiles.grass.top, tiles.grass.top},
    {tiles.grass.left, tiles.grass.centre, tiles.grass.centre, tiles.grass.centre},
  }
end

-- Renders the game map to the screen using tiles
function M.render()
  y_val = 0
  for i, row in pairs(game_map) do
    x_val = letterboxing
    for i, tile in pairs(row) do
      love.graphics.draw(tile, x_val, y_val, 0, tileScale/tileDesity)
      x_val = x_val + scaledTileHeight
    end
    y_val = y_val + scaledTileHeight
  end
end
 
return M