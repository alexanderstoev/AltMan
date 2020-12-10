local _, AltMan = ...;
AltMan.DB = AltMan.DB or {};

----------------------------------------------------------------------------
-- Initialises the data stored by WoW
----------------------------------------------------------------------------
function AltMan.DB:Init()

    -- init the data
    AltManDB = AltManDB or {}
    AltManDB.alts = AltManDB.alts or {}

    -- always reset the current addon version
    -- In the future this will be used for data migtation to newer versions
    AltManDB["version"] = "0.0.1";

    for altKey, alt in pairs(AltManDB.alts) do
        if alt.core.level == 60 then
            AltMan.Alts[altKey] = alt;
        end
    end

    AltMan.Alts[AltMan.currentAltGUID] = {};

    AltMan.TotalAlts = sizeOfTable(AltMan.Alts);
end

----------------------------------------------------------------------------
-- stores data in the DB
----------------------------------------------------------------------------
function AltMan.DB:Store()
    AltManDB.alts = AltMan.Data.data["alt-data"];
end
