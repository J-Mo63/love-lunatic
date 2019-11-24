-- A module for action related methods and variables
local M = {}

-- A table of actions available in the game
local actions = {
  -- secret_bush = {"print", "dialog", 3},
  secret_bush = {"inspect", "assets/res/vert_book.png"},
  special_fence = {"inspect", "assets/res/book.png"},
  map_2_lower_left = {"change_map", "map_2", {x = 16, y = 11}},
  map_2_upper_left = {"change_map", "map_2", {x = 16, y = 3}},
  map_main_lower = {"change_map", "main", {x = 1, y = 11}},
  map_main_upper = {"change_map", "main", {x = 1, y = 3}},
}

-- A dialog table
local dialog = {"broke", "still broke", "worked!"}

-- A method to dispatch the appropritate action given a tag string
function M.dispatch_action(tag)
  -- Get the action instructions for a given tag
  local action_instructions = actions[tag]
  if action_instructions then
    if action_instructions[1] == "print" then
      -- Deliver output actions
      if action_instructions[2] == "dialog" then
        Module.system.to_console = dialog[action_instructions[3]]
      end
    elseif action_instructions[1] == "change_map" then
      -- Deliver map change actions
      Module.scene.change_scene(action_instructions[2], action_instructions[3])
    elseif action_instructions[1] == "inspect" then
      -- Deliver inspect actions
      Module.inspection.inspect_object(action_instructions[2])
    end
  else
    -- Deliver error message to the console
    Module.system.to_console = "null action"
  end
end

return M