-- A module for action related methods and variables
local M = {}

M.actions = {
  secret_bush = {"print", "dialog", 3},
  special_fence = {"change_map", "testing", {x = 1, y = 1}},
  map_2_lower_left = {"change_map", "map_2", {x = 16, y = 11}},
  map_2_upper_left = {"change_map", "map_2", {x = 16, y = 3}},
  map_main_lower = {"change_map", "main", {x = 1, y = 11}},
  map_main_upper = {"change_map", "main", {x = 1, y = 3}},
}

local dialog = {"broke", "still broke", "worked!"}

function M.dispatch_action(action)
  local action_instructions = M.actions[action]
  if action_instructions then
    if action_instructions[1] == "print" then
      if action_instructions[2] == "dialog" then
        Module.system.to_console = dialog[action_instructions[3]]
      end
    elseif action_instructions[1] == "change_map" then
      Module.scene.change_scene(action_instructions[2], action_instructions[3])
    end
  else
    Module.system.to_console = "null action"
  end
end

return M