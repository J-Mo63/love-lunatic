-- A module for dialogue related methods and variables
local M = {}

-- A dialogues table
local dialogue = {"broke", "still broke", "worked!"}

-- A method to display dialogue given a dialogue id value
function M.display_dialogue(dialogue_id)
  -- Display the dialogue on screen
  Module.system.to_console = dialogue[dialogue_id]
end

return M