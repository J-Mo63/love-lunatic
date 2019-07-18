-- A module for map related methods and variables
local M = {}

-- Module fields
local MENU_SCALE = 0.5
local MENU_Y = 20
local MENU_X = 0
local selected_tile = nil
local selected_layer = nil
local selected_tag = ""
local right_side = nil
local menu_tile_scale = nil
local menu_tile_height = nil
local menu_tile_col_max = nil

-- Imported fields
M.map_config = nil
M.tiles = nil
M.game_map = nil

-- Public fields
M.map_updated = false

-- Initialises the map editor module for use
function M.init()
  -- Initialise the default tile and layer as selected
  selected_tile = M.tiles.placeholder
  selected_layer = M.map_config.LAYER_1_KEY

  -- Find the right side of the screen
  right_side = (M.map_config.scaled_tile_height 
    * M.map_config.TILE_DENSITY + M.map_config.letterboxing)

  -- Calculate menu sizing variables
  menu_tile_scale = M.map_config.tile_scale / M.map_config.TILE_DENSITY * MENU_SCALE
  menu_tile_height = selected_tile:getHeight() * menu_tile_scale
  menu_tile_col_max = math.floor((love.graphics.getHeight()-MENU_Y) / menu_tile_height)
end

function save_map()
  -- Construct map data in the recall format
  local save_data = "load_map {"
  for i = 1, M.map_config.TILE_DENSITY do
    save_data = save_data .. "{"
    for j = 1, M.map_config.TILE_DENSITY do
      -- Get the tiles for the map index
      local layer_1_tile = M.game_map[i][j][M.map_config.LAYER_1_KEY] or M.tiles.placeholder
      local layer_2_tile = M.game_map[i][j][M.map_config.LAYER_2_KEY] or M.tiles.transparent
      local tile_tag = M.game_map[i][j][M.map_config.TAG_KEY]
      -- Find references to the tiles
      local layer_1_key
      local layer_2_key
      for tile_key, tile in pairs(M.tiles) do
        if tile == layer_1_tile then
          layer_1_key = tile_key
        end
        if tile == layer_2_tile then
          layer_2_key = tile_key
        end
      end
      -- Append the tile references to the save data
      save_data = save_data .. "{'" .. layer_1_key .. "', '" .. layer_2_key
      if tile_tag then
        -- Append the tile tag to the save data
        save_data = save_data .. "', '" .. tile_tag
      end
      save_data = save_data .. "'},"
    end
    save_data = save_data .. "},"
  end
  save_data = save_data .. "}"

  -- Write the file to appdata
  love.filesystem.write("edit_map.lua", save_data)
end

function load_map(map)
  for i, row in ipairs(map) do
    for j, tile in ipairs(row) do
      map[i][j][M.map_config.LAYER_1_KEY] = M.tiles[tile[M.map_config.LAYER_1_KEY]]
      map[i][j][M.map_config.LAYER_2_KEY] = M.tiles[tile[M.map_config.LAYER_2_KEY]]
    end
  end
  M.game_map = map
end

-- Updates the editor input state
function M.update()
  -- Check if the mouse button is down
  if love.mouse.isDown(1) then
    -- Get the mouse position
    local x, y = love.mouse.getPosition()

    if x > M.map_config.letterboxing and x < right_side then
      -- Work out the x and y coordinates for the mouse in tiles
      local x_tile = math.floor(tonumber((x - M.map_config.letterboxing) / M.map_config.scaled_tile_height)) + 1
      local y_tile = math.floor(tonumber(y / M.map_config.scaled_tile_height)) + 1
      -- Update the selected tile with a sprite
      if selected_layer == 3 then
        M.game_map[y_tile][x_tile][selected_layer] = (selected_tag == "") and nil or selected_tag
      else
        M.game_map[y_tile][x_tile][selected_layer] = selected_tile
      end
      M.map_updated = true
    else
      -- Work out the x and y coordinates for the mouse in menu tiles
      local x_tile = math.floor(tonumber(x / menu_tile_height))
      local y_tile = math.floor(tonumber(y / menu_tile_height))
      -- Calculate the index and search for the tile
      local tile_index = y_tile + (x_tile * menu_tile_col_max)
      local count = 1
      for i, tile in pairs(M.tiles) do
        -- Check if it is the index tile to select
        if count == tile_index then
          selected_tile = tile
        end
        count = count + 1
      end
      M.map_updated = true
    end
  end

  -- Define command functions
  if love.keyboard.isDown("lgui") then
    -- Change the selected layer on numerical input
    if love.keyboard.isDown("1") then
      selected_layer = M.map_config.LAYER_1_KEY
    elseif love.keyboard.isDown("2") then
      selected_layer = M.map_config.LAYER_2_KEY
    elseif love.keyboard.isDown("3") then
      selected_layer = M.map_config.TAG_KEY
    end

    -- Save the current map data to a file on command + s
    if love.keyboard.isDown("s") then
      -- Save the map and inform the user
      save_map()
      to_console = "map saved"
    end

    -- Load the current map data from a file on command + l
    if love.keyboard.isDown("l") then
      require("maps.new_map")
      M.map_updated = true
      to_console = "map loaded"
    end
  end
end

-- Get text input when typing in tag mode
function love.textinput(t)
  if selected_layer == M.map_config.TAG_KEY then
    selected_tag = selected_tag .. t
  end
end

-- Delete characters when typing in tag mode
function love.keypressed(key, isrepeat)
  if selected_layer == M.map_config.TAG_KEY then
    if key == "backspace" then
      selected_tag = selected_tag:sub(1, -2)
    end
  end
end

-- Renders the editor menu to the screen
function M.render()
  -- Display the currently selected tile
  love.graphics.print("Selected:", right_side + 10, 10)
  love.graphics.draw(selected_tile, right_side + 10, 30, 0, menu_tile_scale)

  -- Display the currently selected layer
  love.graphics.print("Layer: " .. selected_layer, right_side + 10, 60)

  -- Display the currently selected tag name
  if selected_layer == 3 then
    love.graphics.print("Tag: " .. selected_tag .. "_", right_side + 10, 80)
  end

  -- Draw the tile menu
  local x_loc = MENU_X
  local y_loc = MENU_Y
  local count = 0
  for i, tile in pairs(M.tiles) do
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

  local y_loc = 0
  for i = 1, M.map_config.TILE_DENSITY do
    local x_loc = M.map_config.letterboxing
    for j = 1, M.map_config.TILE_DENSITY do
      -- Get the tag for the tile
      local tag = M.game_map[i][j][M.map_config.TAG_KEY]
      -- Render the tag to the screen
      if (tag) then
        love.graphics.print(tag, x_loc, y_loc)
      end
      -- Increment the x location of the tile
      x_loc = x_loc + M.map_config.scaled_tile_height
    end
    -- Increment the y location of the tile
    y_loc = y_loc + M.map_config.scaled_tile_height
  end
end
 
return M