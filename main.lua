-- This file is for playing around with the language

local system = require("system")
local player = require("player")

function love.update(dt)
  system.update()
  player.update_movement(dt)
end

function love.draw()
  love.graphics.print("0-0", player.location.x, player.location.y, 50)
end



-- function display_table(table_var)
--   for i, v in ipairs(table_var) do
--     if type(v) == type(table) then
--       print("Found Inner Table:")
--       display_table(v)
--     else
--       print(i, v)
--     end
--   end
-- end

-- test_table = {"hi", {{"hi", {"hi", "hello"}}, "hello"}, "hi", {"hi", {"hi", "hello"}}, key = "val"}

-- table.remove(test_table, 1)

-- display_table(test_table)

-- print(test_table["key"])


-- -- Get the last integer key
-- print(#{1, 2, 3,1, 3,1, 2, 3})