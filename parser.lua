local tokenizer = require"tokenizer"

local parser = {}

local function remove_whitespace(tokens, i)
  while tokens[i].type == "WHITESPACE" do
    i = i + 1
  end
  return i
end

function parser:get_value(tokens, i)

  while i <= #tokens do
    local type = tokens[i].type

    if type == "WHITESPACE" then

    elseif type == "STRING" then
      return tokens[i].value, i + 1
    elseif type == "NUMBER" then
      return tokens[i].value, i + 1
    elseif type == "L_CURL" then
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

  while i <= #tokens do

    local type = tokens[i].type

    if type ~= "WHITESPACE" then
      local value, index = self:get_value(tokens, i)
      table.insert(array, value)
      i = index
      i = remove_whitespace(tokens, i)

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
  local object = {}

  if tokens[i].type ~= "L_CURL" then
    error("Missing starting curly brace")
  end

  while i <= #tokens do
    local type = tokens[i].type

    if type == "R_CURL" then
      return object, i + 1
    elseif type == "STRING" then
      local name = tokens[i].value
      i = i + 1

      if tokens[i].type ~= "COLON" then
        error("Missing colon in object " .. tokens[i].type)
      end
      i = i + 1

      local value, index = self:get_value(tokens, i)
      i = index
      object[name] = value
    else
      i = i + 1
    end
  end

  error("Malformed object")
end

function parser:parse(input)
  local tokens = tokenizer.tokenize(input)
  local json = self:get_object(tokens, 1)
  return json
end

local function is_array(tbl)
  for i, _ in pairs(tbl) do
    if type(i) ~= "number" then
      return false
    end
  end
  return true
end

function parser.to_json(input)
  local function escapeString(s)
        s = string.gsub(s, "\\", "\\\\")
        s = string.gsub(s, "\"", "\\\"")
        s = string.gsub(s, "\n", "\\n")
        s = string.gsub(s, "\r", "\\r")
        s = string.gsub(s, "\t", "\\t")
        return s
    end

    local function serialize(val)
        if type(val) == "table" then
            local isListFlag = is_array(val)
            local result = {}
            for k, v in pairs(val) do
                if isListFlag then
                    table.insert(result, serialize(v))
                else
                    local key = type(k) == "string" and '"' .. escapeString(k) .. '"' or serialize(k)
                    table.insert(result, key .. ":" .. serialize(v))
                end
            end
            if isListFlag then
                return "[" .. table.concat(result, ",") .. "]"
            else
                return "{" .. table.concat(result, ",") .. "}"
            end
        elseif type(val) == "number" or type(val) == "boolean" then
            return tostring(val)
        elseif type(val) == "string" then
            return '"' .. escapeString(val) .. '"'
        else
            return '"Unsupported Type"'
        end
    end

    return serialize(input)
end

return parser



