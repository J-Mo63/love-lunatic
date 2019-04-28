-- This file is for playing around with the language

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