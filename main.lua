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

-- local tokens = tokenizer.tokenize(" \"string\" ")
-- tokenizer.print(tokens)

-- local tokens = parser.parse(json:read("a"))
-- local tokens = parser.parse(" \"string\\\"\" true false null")
-- local tokens = parser.parse(" \"string\" ")
local tokens = parser:parse("[\"hi\", \"there\", \"mister\", \"monkey\", [1,2,3]]")
-- local tokens = parser.parse("][true {} ")
-- local tokens = parser.parse("11924.2019312938")
json:close()
-- print(tokens)
