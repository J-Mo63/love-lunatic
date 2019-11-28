-- A module for dialogue related methods and variables
local M = {}

-- Module constants
local MAX_WIDTH = 20

-- A dialogue table
local dialogue_table = {
  not_bush = {"This is", "not a line of text", "to be read", "by the player character."}, 
  bush = {"This is", "another line of text", "to be read", "by the player character."}, 
  fence = {"This is", "a line of text", "to be read", "by the player character."}
}

-- Module fields
local dialogue = nil
local current_line = 0
local dialogue_line = nil

-- A method to display dialogue given a dialogue id value
function M.display_dialogue(dialogue_id)
  -- Display the dialogue on screen
  dialogue = dialogue_table[dialogue_id]
  Module.player.control_override = true
  Module.system.key_bindings.f = M.progress_dialogue
  M.progress_dialogue()
end

function M.progress_dialogue()
  current_line = current_line + 1
  dialogue_line = dialogue[current_line]
  if dialogue_line == nil then
    Module.system.reset_key_bindings()
    Module.player.control_override = false
    current_line = 0
  end
end

function M.render()
  if dialogue_line then
    local font = love.graphics.getFont()
    local font_width = font:getWidth(dialogue_line)
    local y_position = Module.player.transform.y - Module.player.transform.h
    local x_position = Module.player.transform.x - (font_width / 2) + (Module.player.transform.w / 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", x_position - 3, y_position - 3, font_width + 6, font:getHeight(dialogue_line) + 6, 3)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(dialogue_line, x_position, y_position)
    love.graphics.reset()
  end
end

return M