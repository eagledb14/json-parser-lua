local parser = require"parser"

local function printTable(t, indent)
    indent = indent or ""
    for key, value in pairs(t) do
        if type(value) == "table" then
            print(indent .. tostring(key) .. ":")
            printTable(value, indent .. "  ")
        else
            print(indent .. tostring(key) .. ": " .. tostring(value))
        end
    end
end

local json = io.open("menu-example.txt")
if json == nil then
  print("n")
  os.exit()
end
local data = json:read("a")
json:close()

-- local tokens = tokenizer.tokenize(" \"string\" ")
-- tokenizer.print(tokens)

-- print(type(data), #data)
local tokens = parser:parse(data)
-- local tokens = parser.parse(" \"string\\\"\" true false null")
-- local tokens = parser.parse(" \"string\" ")
-- local tokens = parser:parse("{\"jeff\": [\"hi\", \"there\", \"mister\", \"monkey\", [1,2,3]]}")
-- local tokens = parser:parse("{\"jim\": [1,2,3]}")
printTable(tokens)
