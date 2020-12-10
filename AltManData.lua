local _, AltMan = ...;
AltMan.Data = AltMan.Data or {};
AltMan.Data.data = {};

local DataSourcesTypes = {
    ["server-data"] = {"weeklyreset", "dailyreset"},
    ["alt-data"] = {
        ["core"] = {"name", "class", "level"},
        ["daily"] = {"mawdailies", "worldquests", "covenantcalling"},
        ["weekly"] = {"mythicplus", "dungeonquests", "rescuesouls", "animaquest", "soulash", "worldboss"},
    }
}
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:PrepareData()

    AltMan.currentAltGUID = UnitGUID('player');
    AltMan.TotalAlts = sizeOfTable(AltMan.Alts);

    AltMan.Data:GetData("server-data", true);
    AltMan.Data:GetData("alt-data-core", true);
    AltMan.Data:GetData("alt-data-daily", true);
    AltMan.Data:GetData("alt-data-weekly", true);

end


----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:GetData(type, refresh)

    local dataSources = DataSourcesTypes[type];
    local destination = AltMan.Data.data

    if (type:sub(1,8) == "alt-data") then
        type = string.gsub(type, "alt%-data%-", "");
        dataSources = DataSourcesTypes["alt-data"][type];

        AltMan.Data.data["alt-data"] = AltMan.Data.data["alt-data"] or {} -- need to make sure this is existing
        destination = AltMan.Data.data["alt-data"]
    end

    if (refresh or destination[type] == nil) then
        destination[type] = {}
        for _, source in pairs(dataSources) do
            local value = AltMan.DataSources[source]();
            destination[type][source] = value;
        end
    end

    return destination[type];
end


----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:GetAltsInfo(refresh)
    local altsDataSources = {"weeklyreset", "dailyreset"}

    if (refresh or AltMan.Data.data.altsData == nil) then
        AltMan.Data.data.altsData = {};
        for k, source in pairs(altsDataSources) do
            AltMan.Data.data.altsData[source] = AltMan.DataSources[source]();
        end
    end

    return AltMan.Data.data.altsData;
end


















AltMan.Alts = {};
AltMan.TotalAlts = 0;

AltMan.altData = {
    "name", "class", "level" -- general alt data
}
AltMan.altActivities = {}
AltMan.altActivities.daily = {
    "mawdailies", "worldquests", "covenantcalling" -- daily activities
}
AltMan.altActivities.weekly = {
    "mythicplus", "dungeonquests", "rescuesouls", "animaquest", "soulash", "worldboss" -- weekly activities
}













function AltMan:GetCurrentCharacterData()
    local character = {}

    character = AltMan:GetDataGroupValues(character, AltMan.altData);
    character = AltMan:GetDataGroupValues(character, AltMan.altActivities.daily);
    character = AltMan:GetDataGroupValues(character, AltMan.altActivities.weekly);

    return character
end;


function AltMan:GetDataGroupValues(character, dataGroup)
    for _, dataGroupEntry in pairs(dataGroup) do
        -- first check if we have a data source for the entry
        if (not (AltMan.DataSources[dataGroupEntry] == nil)) then
            character[dataGroupEntry] = AltMan.DataSources[dataGroupEntry]()
        end
    end
    return character;
end




