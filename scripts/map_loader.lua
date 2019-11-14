-- A module for loading the map from a file in the maps folder
local M = {}

-- Module Fields
M.load_module = nil
M.map_config = nil
M.tiles = nil

function M.init(filename, load_module)
    -- Set the fields
    M.load_module = load_module
    M.map_config = M.load_module.map_config
    M.tiles = M.load_module.tiles

    -- Start loading the map file
    local map = require("maps." .. filename)
    map.init()
end

-- Loads the map in and calls a function to return it to the parent module
function load_map(map)
  for i, row in ipairs(map) do
    for j, tile in ipairs(row) do
      map[i][j][M.map_config.LAYER_1_KEY] = M.tiles[tile[M.map_config.LAYER_1_KEY]]
      map[i][j][M.map_config.LAYER_2_KEY] = M.tiles[tile[M.map_config.LAYER_2_KEY]]
    end
  end
  -- Perform a callback to return the map
  M.load_module.update_map(map)
end

return M