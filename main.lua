-- This file is for playing around with the language

local text = {
  x  = 100,
  y  = 100,
  speed = 4,
}

local magnitude = 1

function love.update(dt)
  -- Make the application quit on command + w
  if love.keyboard.isDown("lgui") and love.keyboard.isDown("w") then
    love.event.quit()
  end

  a_x = 0
  a_y = 0

  if love.keyboard.isDown("right") then
    a_x = (dt * 100)
  end
  if love.keyboard.isDown("left") then
    a_x = -(dt * 100)
  end
  if love.keyboard.isDown("down") then
    a_y = (dt * 100)
  end
  if love.keyboard.isDown("up") then
    a_y = -(dt * 100)
  end

  -- Normalise movement
  magnitude = math.sqrt(a_x^2 + a_y^2)
  if magnitude > 1 then
    text.x = text.x + (a_x / magnitude) * text.speed
    text.y = text.y + (a_y / magnitude) * text.speed
  end
end

function love.draw()
  love.graphics.print(magnitude, text.x, text.y, 50)
end

print("hello, world")

function display_table(table_var)
  for i, v in ipairs(table_var) do
    if type(v) == type(table) then
      print("Found Inner Table:")
      display_table(v)
    else
      print(i, v)
    end
  end
end

test_table = {"hi", {{"hi", {"hi", "hello"}}, "hello"}, "hi", {"hi", {"hi", "hello"}}, key = "val"}

table.remove(test_table, 1)

display_table(test_table)

print(test_table["key"])


local more = require("more")

more.run()


-- Get the last integer key
print(#{1, 2, 3,1, 3,1, 2, 3})