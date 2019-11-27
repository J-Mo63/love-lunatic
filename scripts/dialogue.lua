-- A module for dialogue related methods and variables
local M = {}

-- A dialogues table
local dialogue_table = {"broke", "still broke", "worked! this motherfucking worked dude!"}

local dialogue = ""
local max_width = 10

-- A method to display dialogue given a dialogue id value
function M.display_dialogue(dialogue_id)
  -- Display the dialogue on screen
  dialogue = dialogue_table[dialogue_id]
end

function M.render()
  local font = love.graphics.getFont()
  local dialogue_chunk = string.sub(dialogue, 1, max_width)
  local font_width = font:getWidth(dialogue_chunk)
  local y_position = Module.player.transform.y - Module.player.transform.h
  local x_position = Module.player.transform.x - (font_width / 2) + (Module.player.transform.w / 2)
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", x_position, y_position, font_width, font:getHeight(dialogue_chunk))
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(dialogue_chunk, x_position, y_position)
  love.graphics.reset()
end

return M