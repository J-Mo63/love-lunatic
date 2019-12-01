-- A module for action related methods and variables
local M = {}

-- A table of actions available in the game
local actions = nil

function M.init()
  actions = require("action_table")
end

-- A method to dispatch the appropritate action given a tag string
function M.dispatch_action(tag)
  -- Get the action instructions for a given tag
  local action_instructions = actions[tag]
  if action_instructions then
    if action_instructions[1] == "dialogue" then
      -- Deliver dialogue actions
      Module.dialogue.display_dialogue(action_instructions[2])
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