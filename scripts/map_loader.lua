local M = {}

-- Module Fields
M.load_module = nil
M.map_config = nil
M.tiles = nil

function M.init(filename, load_module)
    M.load_module = load_module
    M.map_config = M.load_module.map_config
    M.tiles = M.load_module.tiles
    require("maps." .. filename)
end

function load_map(map)
  for i, row in ipairs(map) do
    for j, tile in ipairs(row) do
      map[i][j][M.map_config.LAYER_1_KEY] = M.tiles[tile[M.map_config.LAYER_1_KEY]]
      map[i][j][M.map_config.LAYER_2_KEY] = M.tiles[tile[M.map_config.LAYER_2_KEY]]
    end
  end
  M.load_module.update_map(map)
end

return M