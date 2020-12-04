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