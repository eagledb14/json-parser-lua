
local meta_string = {
  __tostring = function (obj)
    if obj.value == nil then
      return obj.type
    end

    return obj.type .. ": " .. tostring(obj.value)
  end
}

local token = {}

function token.new(type, value)
  local new_token = {}
  new_token["type"] = type

  if value ~= nil then
    new_token["value"] = value
  end

  setmetatable(new_token, meta_string)

  return new_token
end





return token
