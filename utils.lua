local utils = {}

function utils.isWhitespace(char)
    return char:match("^%s*$") ~= nil
end

function utils.isLetter(char)
    return char:match("^%a+$") ~= nil
end

function utils.isDigit(char)
    return char:match("^%d+$") ~= nil
end

function utils.getString(str, i)
    local new_string = ""

    local prev_char = ""
    while i < #str do
        i = i + 1
        local char = str:sub(i, i)

        if char == "\"" and prev_char ~= "\\" then
            return new_string, i
        end

        new_string = new_string .. char
        prev_char = char
    end

    return new_string, i - 1
end

function utils.getBool(char, i)
    if char == "t" then
        return "TRUE", i + 3
    elseif char == "f" then
        return "FALSE", i + 4
    elseif char == "n" then
        return "NULL", i + 3
    else
        -- return "BOOL_ERROR", i
        error("Broken string at " .. i)
    end
end

function utils.getNumber(str, i)
    local new_number = ""

    if str:sub(i,i) == '-' then
        new_number = new_number .. "-"
        i = i + 1
    end

    while true do
        local char = str:sub(i,i)

        if utils.isDigit(char) or string.lower(char) == "e" or char == "." or char == "-" or char == "+" then
            new_number = new_number .. char
        else
            break
        end
        i = i + 1
    end

    local number = tonumber(new_number)
    if number == nil then
        error("Malformed number at " .. i)
    end

    return number, i - 1
end

return utils
