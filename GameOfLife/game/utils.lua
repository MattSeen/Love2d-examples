-- http://stackoverflow.com/a/641993/1367612
function table.shallow_copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

-- Based on: http://stackoverflow.com/a/664611/1367612
function table.copy(tableToCopy)
	local tablesDouble = {}
	for key, value in pairs(tableToCopy) do tablesDouble[key] = value end
	return setmetatable(tablesDouble, getmetatable(tableToCopy))
end

-- Based on: https://gist.github.com/MihailJP/3931841
function table.deepCopy(t)
	if type(t) ~= "table" then return t end
	
	local meta = getmetatable(t)
	local target = {}
	
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = table.deepCopy(v)
		else
			target[k] = v
		end
	end
	setmetatable(target, meta)
	return target
end

function longestLineWidth(text)
    local longest = 0
    for i,v in ipairs(lines(helptext)) do
        local lineLength = font:getWidth(v)
        if lineLength > longest then
            longest = lineLength
        end
    end

    return longest
end

-- Source: http://www.twolivesleft.com/Codea/Talk/discussion/2118/split-a-string-by-return-newline/p1
-- Lua doesn't provide any convenient methods for splitting strings like most languages.
function lines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end
