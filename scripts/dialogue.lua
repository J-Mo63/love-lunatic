-- A module for dialogue related methods and variables
local M = {}

-- Module constants
local MAX_WIDTH = 20
local TEXT_SPEED = 0.3

-- A dialogue table
local dialogue_table = {
  not_bush = {"player", "This is", "player", "not a line of text", "player", "to be read", "player", "by the player character."}, 
  bush = {"player", "Hello there!", "bush", "Hi-ho traveller!", "bush", "I am but a humble bush", "player", "A season's greetings to you then", "bush", "Do you not know", "bush", "the dangers of speaking to bushes???"}, 
  fence = {"player", "This is", "player", "a line of text", "player", "to be read", "player", "by the player character."}
}

-- Module fields
local dialogue = nil
local current_line = -1
local dialogue_line = nil
local current_char = 0
local control_override = false
local actor_transforms = nil
local current_transform = nil
local current_actor = nil

-- A method to display dialogue given a dialogue id value
function M.display_dialogue(dialogue_id, transforms)
  -- Display the dialogue on screen
  dialogue = dialogue_table[dialogue_id]
  Module.player.control_override = true
  actor_transforms = transforms
  Module.system.key_bindings.f = M.progress_dialogue
  M.progress_dialogue()
end

function M.progress_dialogue()
  if not control_override then
    current_line = current_line + 2
    current_actor = dialogue[current_line]
    if current_actor == "player" then
      current_transform = Module.player.transform
    elseif current_actor then
      current_transform = Module.map.transform_to_tile_location(actor_transforms[current_actor])
    end
    dialogue_line = dialogue[current_line + 1]
    current_char = 0
    if dialogue_line == nil then
      Module.system.reset_key_bindings()
      Module.player.control_override = false
      current_line = -1
    end
    control_override = true
  end
end

function M.update(dt)
  if dialogue_line and current_char < string.len(dialogue_line) then
    current_char = current_char + TEXT_SPEED
  elseif control_override then
    control_override = false
  end
end

function M.render()
  if dialogue_line then
    displayed_dialogue_line = string.sub(dialogue_line, 1, current_char)
    local font = love.graphics.getFont()
    local font_width = font:getWidth(displayed_dialogue_line)
    local y_position = current_transform.y - (current_transform.h / 2)
    if current_actor == "player" then
      y_position = y_position - (current_transform.h / 2)
    end
    local x_position = current_transform.x - (font_width / 2) + (current_transform.w / 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", x_position - 3, y_position - 3, font_width + 6, font:getHeight(displayed_dialogue_line) + 6, 3)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(displayed_dialogue_line, x_position, y_position)
    love.graphics.reset()
  end
end

return M