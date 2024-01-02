local tokenizer = require"tokenizer"
local parser = require"parser"

local function hi()
  print("hello world")
end

local json = io.open("glossary-example.txt")
if json == nil then
  print("n")
  os.exit()
end

local tokens = parser.parse(json:read("a"))
-- local tokens = parser.parse(" \"string\\\"\" true false null")
-- local tokens = parser.parse("][true {} ")
-- local tokens = parser.parse("11924.2019312938")
json:close()
