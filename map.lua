-- A module for player and player controller related methods and variables
local M = {}

local tileDesity = 16
local tileHeight = nil
local tileScale = nil

local tiles = {
  grass = {},
}

local game_map = nil

local function load_tiles()
  -- Register all tile types to the tiles table
  tiles.grass.centre = love.graphics.newImage("/assets/tiles/grass-centre.png")
  tiles.grass.bottom = love.graphics.newImage("/assets/tiles/grass-bottom.png")
  tiles.grass.top = love.graphics.newImage("/assets/tiles/grass-top.png")
  tiles.grass.left = love.graphics.newImage("/assets/tiles/grass-left.png")
  tiles.grass.right = love.graphics.newImage("/assets/tiles/grass-right.png")
  tiles.grass.topLeft = love.graphics.newImage("/assets/tiles/grass-top-left.png")
end

function M.init()
  load_tiles()

  tileHeight = tiles.grass.centre:getWidth()
  
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  

  letterboxing = (screenWidth-screenHeight)/2

  scaleVal = screenHeight/tileHeight
  tileScale = tileHeight*scaleVal/tileDesity

  game_map = {
    {tiles.grass.topLeft, tiles.grass.top, tiles.grass.top, tiles.grass.top},
    {tiles.grass.left, tiles.grass.centre, tiles.grass.centre, tiles.grass.centre},
  }
end

function M.render()
  y_val = 0
  for i, row in ipairs(game_map) do
    x_val = letterboxing
    for i, tile in ipairs(row) do
      love.graphics.draw(tile, x_val, y_val, 0, scaleVal/tileDesity)
      x_val = x_val + tileScale
    end
    y_val = y_val + tileScale
  end
end
 
return M