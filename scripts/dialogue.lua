-- A module for dialogue related methods and variables
local M = {}

-- A dialogues table
local dialogue_table = {"broke", "still broke", "worked!"}

local dialogue = ""

-- A method to display dialogue given a dialogue id value
function M.display_dialogue(dialogue_id)
  -- Display the dialogue on screen
  dialogue = dialogue_table[dialogue_id]
end

function M.render()
  local font = love.graphics.getFont()
  local centred = (love.graphics.getWidth() / 2) - (font:getWidth(dialogue) / 2)
  love.graphics.print(dialogue, centred, love.graphics.getHeight() * 0.95)
end

return M