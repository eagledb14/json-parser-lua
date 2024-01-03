# Json Parser
This is a json parser that I wrote in a few hours. It's not perfect, though I think it works as it should. Deserializing should always work with valid json and will probably validate non-valid json. The Serializer should work for simpler object types. It does not work for more complex types and self references.
Generally you should not use this for anything other than as inspiration to create your own, use a proper library in production. I mostly made this to see if I could, more of a toy project than something that should be used.

# Use
```
local parser = require"parser"

local test_array = {28,18,9,26,104}
local test_object = {
  bread = "availabe"
  id = 427
  lastname = "Smith"
}

-- tables to json
local json_array = parser.to_json(test_array)
local json_object = parser.to_json(test_object)
print(json_array)
print(json_object)

-- json to tables
local array = parser:parse(json_array)
local object = parser:parse(json_object)
print(array)
print(object)
```
