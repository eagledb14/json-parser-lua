local tokenizer = require"tokenizer"

local parser = {}

function parser:get_value(tokens, i)

  while i < #tokens do
    local type = tokens[i].type

    if type == "WHITESPACE" then

    elseif type == "STRING" then
      return tokens[i].value, i + 1
    elseif type == "NUMBER" then
      return tokens[i].value, i + 1
    elseif type == "L_CURl" then
      local value, index = self:get_object(tokens, i)
      return value, index
    elseif type == "L_SQUARE" then
      local value, index = self:get_array(tokens, i)
      return value, index
    elseif type == "TRUE" then
        return true, i + 1
    elseif type == "FALSE" then
      return false, i + 1
    elseif type == "NULL" then
        return nil, i + 1
    end

    i = i + 1
  end

  error("Malformed value")
end

function parser:get_array(tokens, i)
  local array = {}
  i = i + 1

  while i < #tokens do

    local type = tokens[i].type

    if type ~= "WHITESPACE" then
      local value, index = self:get_value(tokens, i)
      table.insert(array, value)
      i = index

      type = tokens[i].type
      if type == "R_SQUARE" then
        return array, i + 1
      elseif type ~= "COMMA" then
        error("Malformed array, missing comma or closing bracket")
      end
    end
    i = i + 1
  end

  error("Malformed array " .. i)
end

function parser:get_object(tokens, i)

end

function parser:parse(input)
  local tokens = tokenizer.tokenize(input)
  -- tokenizer.print(tokens)

  -- return get_object(input, 1)
  -- print(self:get_value(tokens, 1))
  local arr = self:get_array(tokens, 1)
  for i, val in ipairs(arr) do
    if type(val) == "table" then
      for j, var in ipairs(val) do
        print(var)
      end
    else
      print(val)
    end
  end
  -- return get_value(tokens, 1)
end


function parser.to_json(input)
end

return parser



