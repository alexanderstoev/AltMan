local _, AltMan = ...;

----------------------------------------------------------------------------
-- Returns the number of entries in an array
-- A bit more complex since in LUA all are tables
-- AND I CANT BELEIVE IT: but there is no built in method for this
-- google lua table getn
----------------------------------------------------------------------------
function sizeOfTable(t)
	local items = 0
	for k, v in pairs(t) do items = items + 1 end
	return items
end


----------------------------------------------------------------------------
-- remove trailing and leading whitespace from string.
----------------------------------------------------------------------------
function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end


----------------------------------------------------------------------------
-- iterates over the table in a sorted order
-- more info on stackoverflow:
-- https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
----------------------------------------------------------------------------
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


function compareAlts(t,a,b)

    -- push the current alt to the front
	if (a == AltMan.currentAltGUID) then
        return true;
    elseif (b == AltMan.currentAltGUID) then
        return  false;
    end

    -- sort alphabeticaly
	if (t[a].name < t[b].name) then
		return true;
	end
	return false;
end