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