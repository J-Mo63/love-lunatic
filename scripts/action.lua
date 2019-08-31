-- A module for action related methods and variables
local M = {}

M.actions = {
  secret_bush = {"print", "dialog", 3}
}

local dialog = {"broke", "still broke", "worked!"}

function M.init()
end

function M.dispatch_action(action)
  action_instructions = M.actions[action]

  if action_instructions then
    if action_instructions[1] == "print" then
      if action_instructions[2] == "dialog" then
        to_console = dialog[action_instructions[3]]
      end
    end
  else
    to_console = "null action"
  end
end

return M