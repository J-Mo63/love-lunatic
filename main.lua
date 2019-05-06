-- Import the required system modules
local system = require("system")
local player = require("player")

local tiles = {
  grassCentre = nil,
  grassBottom = nil,
  grassTop = nil,
  grassRight = nil,
  grassLeft = nil,
  grassTopLeft = nil,
}

local height = nil
local tileWidth = nil

local scaleVal = nil

function love.load()
  tiles.grassCentre = love.graphics.newImage("/assets/tiles/grass-centre.png")
  tiles.grassBottom = love.graphics.newImage("/assets/tiles/grass-bottom.png")
  tiles.grassTop = love.graphics.newImage("/assets/tiles/grass-top.png")
  tiles.grassLeft = love.graphics.newImage("/assets/tiles/grass-left.png")
  tiles.grassRight = love.graphics.newImage("/assets/tiles/grass-right.png")
  tiles.grassTopLeft = love.graphics.newImage("/assets/tiles/grass-top-left.png")
  tileWidth = tiles.grassCentre:getWidth()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  letterboxing = (width-height)/2

  scaleVal = height/tileWidth

  centre_x = love.graphics.getWidth()/2
  centre_y = love.graphics.getHeight()/2

  player.location.x = centre_x
  player.location.y = centre_y

  game_map = {
    {tiles.grassTopLeft, tiles.grassTop, tiles.grassTop, tiles.grassTop},
    {tiles.grassLeft, tiles.grassCentre, tiles.grassCentre, tiles.grassCentre},
  }
end

function love.update(dt)
  system.update()
  player.update_movement(dt)
end

function love.draw()
  draw_map()
  love.graphics.print("-_-", player.location.x, player.location.y, 0)
end

function draw_map()
  tileHeight = tileWidth*scaleVal/4

  y_val = 0
  for i, row in ipairs(game_map) do
    x_val = letterboxing
    for i, tile in ipairs(row) do
      love.graphics.draw(tile, x_val, y_val, 0, scaleVal/4)
      x_val = x_val + tileHeight
    end
    y_val = y_val + tileHeight
  end
end



-- function display_table(table_var)
--   for i, v in ipairs(table_var) do
--     if type(v) == type(table) then
--       print("Found Inner Table:")
--       display_table(v)
--     else
--       print(i, v)
--     end
--   end
-- end

-- test_table = {"hi", {{"hi", {"hi", "hello"}}, "hello"}, "hi", {"hi", {"hi", "hello"}}, key = "val"}

-- table.remove(test_table, 1)

-- display_table(test_table)

-- print(test_table["key"])


-- -- Get the last integer key
-- print(#{1, 2, 3,1, 3,1, 2, 3})