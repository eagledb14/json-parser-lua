local token = require("token")
local const = require("const")
local utils = require"utils"

local tokenizer = {}
-- tokenizer.tokens = {}

function tokenizer.tokenize(input)
  local tokens = {}
  local i = 1
  while i <= #input do
    local char = input:sub(i, i)

    if utils.isWhitespace(char) == true then
      table.insert(tokens, token.new("WHITESPACE", nil))
    elseif char == const.L_CURL then
      table.insert(tokens, token.new("L_CURL", nil))
    elseif char == const.R_CURL then
      table.insert(tokens, token.new("R_CURL", nil))
    elseif char == const.COMMA then
      table.insert(tokens, token.new("COMMA", nil))
    elseif char == const.COLON then
      table.insert(tokens, token.new("COLON", nil))
    elseif char == const.L_SQUARE then
      table.insert(tokens, token.new("L_SQUARE", nil))
    elseif char == const.R_SQUARE then
      table.insert(tokens, token.new("R_SQUARE", nil))
    -- gets strings
    elseif char == const.QUOTE then
      local new_string, index = utils.getString(input, i)
      table.insert(tokens, token.new("STRING", new_string))
      i = index
    -- checks for boolean values, true, false, and null
    elseif utils.isLetter(char) then
      local token_name, index = utils.getBool(char, i)
      table.insert(tokens, token.new(token_name, nil))
      i = index
    -- gets numbers
    elseif utils.isDigit(char) or char == "-" then
      local value, index = utils.getNumber(input, i)
      table.insert(tokens, token.new("NUMBER", value))
      i = index
    else
      table.insert(tokens, token.new("ERROR", char))
    end

    i = i + 1
  end

  return tokens
end

function tokenizer.print(tokens)
  for _, value in ipairs(tokens) do
    -- if value.type ~= "WHITESPACE" then
    --   print(value)
    -- end
    print(value)
  end
end

return tokenizer
