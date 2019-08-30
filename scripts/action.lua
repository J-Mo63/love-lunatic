-- A module for action related methods and variables
local M = {}

M.actions = {
  secret_bush = {"print", "dialog", 3}
}


function M.init()
end

function M.dispatch_action(action)
  action_instructions = M.actions[action]

  if action_instructions[1] == "print" then
    if action_instructions[2] == "dialog" then
    end
  end
end

return M