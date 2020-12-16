local _, AltMan = ...;

----------------------------------------------------------------------------
-- Returns the number of entries in an array
-- A bit more complex since in LUA all are tables
-- AND I CANT BELEIVE IT: but there is no built in method for this
-- google lua table getn
----------------------------------------------------------------------------
function sizeOfTable(t)
    local items = 0
    for k, v in pairs(t) do
        items = items + 1
    end
    return items
end

----------------------------------------------------------------------------
-- remove trailing and leading whitespace from string.
----------------------------------------------------------------------------
function Trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

----------------------------------------------------------------------------
-- format time
----------------------------------------------------------------------------
function GetRemainingTime(seconds)

    if (seconds < AltMan.constants.secondsinhalfhour) then
        -- return minutes
        return RoundNumber(seconds / 60) .. " " .. AltMan.translations["en"]["time"]["minutes"]
    elseif (seconds < AltMan.constants.secondsinhour) then
        return AltMan.translations["en"]["time"]["lessthanhour"];
    elseif (seconds < AltMan.constants.secondsinday) then
        -- return hours
        return RoundNumber(seconds / AltMan.constants.secondsinhour) .. " " ..
                   AltMan.translations["en"]["time"]["hours"]
    else
        -- return days
        return RoundNumber(seconds / AltMan.constants.secondsinday) .. " " .. AltMan.translations["en"]["time"]["days"]
    end
end

----------------------------------------------------------------------------
-- round a number
----------------------------------------------------------------------------
function RoundNumber(number)
    return math.floor(0.5 + number);
end

----------------------------------------------------------------------------
-- iterates over the table in a sorted order
-- more info on stackoverflow:
-- https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
----------------------------------------------------------------------------
function Spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do
        keys[#keys + 1] = k
    end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a, b)
            return order(t, a, b)
        end)

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

----------------------------------------------------------------------------
-- compares alts by name alphabeticaly
-- and always pushes the current alt on first place
----------------------------------------------------------------------------
function CompareAlts(t, a, b)

    -- push the current alt to the front
    if (a == AltMan.currentAltGUID) then
        return true;
    elseif (b == AltMan.currentAltGUID) then
        return false;
    end

    -- sort alphabeticaly
    if (t[a].core.name < t[b].core.name) then
        return true;
    end
    return false;
end

----------------------------------------------------------------------------
-- compares datasources by index
----------------------------------------------------------------------------
function CompareDataSources(t, a, b)
    if (a < b) then
        return true;
    end
    return false;
end
