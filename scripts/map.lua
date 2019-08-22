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
  map_tile_scale = nil,
  letterboxing = nil,
}

-- A list of tiles used in the game
M.tiles = {}

-- The ingame map to be displayed
M.game_map = {}

-- The map canvas to be drawn
local map_canvas = nil

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
  local new_map = {}
  for i = 1, M.map_config.TILE_DENSITY do
    local row = {}
    for i = 1, M.map_config.TILE_DENSITY do
      table.insert(row, {})
    end
    table.insert(new_map, row)
  end
  return new_map
end

-- Returns a list of collidable items
function M.get_collidable_objects()
  local collidable_objects = {}
  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = 0
    for j = 1, M.map_config.TILE_DENSITY do
      -- Check if the boundary tile exists in the map
      local boundary_tile = M.game_map[i][j][M.map_config.LAYER_2_KEY] or M.tiles.transparent
      if boundary_tile ~= M.tiles.transparent then
        -- Add it to the boundary table
        table.insert(collidable_objects, 
          {x_loc + M.map_config.letterboxing, y_loc,
           M.map_config.scaled_tile_height, M.map_config.scaled_tile_height})
      end
      -- Increment the x location of the tile
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    -- Increment the y location of the tile
    y_loc = y_loc + M.map_config.scaled_tile_height
  end

  -- Add game screen borders to collidable objects
  table.insert(collidable_objects, 
    {0, 0, M.map_config.letterboxing, love.graphics.getHeight()})
  table.insert(collidable_objects, 
    {M.map_config.letterboxing, -1, love.graphics.getWidth(), 10})
  table.insert(collidable_objects, 
    {love.graphics.getWidth() - M.map_config.letterboxing, 0, 
     M.map_config.letterboxing, love.graphics.getHeight()})
  table.insert(collidable_objects, 
    {0, love.graphics.getHeight() + 1, love.graphics.getWidth(), 10})

  return collidable_objects
end

function M.get_tagged_objects()
  local tagged_objects = {}
  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = 0
    for j = 1, M.map_config.TILE_DENSITY do
      -- Check if the tagged tile exists in the map
      local tagged_tile = M.game_map[i][j][M.map_config.TAG_KEY] or M.tiles.transparent
      if tagged_tile ~= M.tiles.transparent and tagged_tile ~= "" then
        -- Add it to the boundary table
        table.insert(tagged_objects, 
          {x_loc + M.map_config.letterboxing, y_loc,
           M.map_config.scaled_tile_height, M.map_config.scaled_tile_height})
      end
      -- Increment the x location of the tile
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    -- Increment the y location of the tile
    y_loc = y_loc + M.map_config.scaled_tile_height
  end

  return tagged_objects
end

-- Initialises the map module for use
function M.init()
  -- Load the tiles
  load_tiles()

  -- Get the height of the imported tileset
  local tileset_height = M.tiles.placeholder:getWidth()
  
  -- Get the screen dimensions
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()

  -- Get the tile-scaling variables
  M.map_config.tile_scale = screen_height / tileset_height
  M.map_config.scaled_tile_height = tileset_height * M.map_config.tile_scale / M.map_config.TILE_DENSITY
  M.map_config.map_tile_scale = M.map_config.tile_scale / M.map_config.TILE_DENSITY

  -- Calculate the letterboxing offset
  M.map_config.letterboxing = (screen_width - screen_height)/2

  -- Initialse the map canvas
  map_canvas = love.graphics.newCanvas(screen_height, screen_height)

  -- Load the game map and draw it to the canvas
  M.update_map(load_map())
end

-- Updates the module map externally and redraws the canvas
function M.update_map(game_map)
  -- Update the stored game map
  M.game_map = game_map
  -- Create and initialse the map canvas with tiles
  map_canvas = love.graphics.newCanvas(screen_height, screen_height)
  update_canvas()
end

-- Updates the canvas with a new map
function update_canvas()
  love.graphics.setCanvas(map_canvas)
  love.graphics.clear()
  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = 0
    for j = 1, M.map_config.TILE_DENSITY do
      -- Check if the tile exists in the map
      local tile1 = M.game_map[i][j][M.map_config.LAYER_1_KEY] or M.tiles.placeholder
      local tile2 = M.game_map[i][j][M.map_config.LAYER_2_KEY] or M.tiles.transparent
      -- Render it to the screen
      love.graphics.draw(tile1, x_loc, y_loc, 0, M.map_config.map_tile_scale)
      love.graphics.draw(tile2, x_loc, y_loc, 0, M.map_config.map_tile_scale)
      -- Increment the x location of the tile
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    -- Increment the y location of the tile
    y_loc = y_loc + M.map_config.scaled_tile_height
  end
  love.graphics.setCanvas(nil)
end

-- Renders the game map to the screen
function M.render()
  -- Draw the map canvas with the letterbox offset
  love.graphics.draw(map_canvas, M.map_config.letterboxing)
end
 
return M