local _, AltMan = ...;

AltMan.Alts = AltMan.Alts or {};
AltMan.TotalAlts = AltMan.TotalAlts or 0;

AltMan.Data = AltMan.Data or {};
AltMan.Data.data = {};

AltMan.Data.dataSourcesTypes = {
    ["server-data"] = {
        [1] = "dailyreset",
        [2] = "weeklyreset"
    },
    ["alt-data"] = {
        ["core"] = {
            [1] = "name",
            [2] = "class",
            [3] = "level"
        },
        ["daily"] = {
            [1] = "covenantcalling",
            [2] = "mawdailies",
            [3] = "worldquests"
        },
        ["weekly"] = {
            [1] = "mythicplus",
            [2] = "dungeonquests",
            [3] = "rescuesouls",
            [4] = "animaquest",
            [5] = "soulash",
            [6] = "worldboss"
        }
    }
}
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:PrepareData()

    AltMan.TotalAlts = sizeOfTable(AltMan.Alts);

    AltMan.Data.data = AltMan.Data.data or {}

    AltMan.Data:GetData("server-data", true);

    for altKey, alt in Spairs(AltMan.Alts, CompareAlts) do
        AltMan.Data:GetAltData("alt-data-core", true, altKey, alt);
        AltMan.Data:GetAltData("alt-data-daily", true, altKey, alt);
        AltMan.Data:GetAltData("alt-data-weekly", true, altKey, alt);
    end

end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:RefreshCurrentAltData()
    AltMan.Data:GetData("server-data", true);
    AltMan.Data:GetAltData("alt-data-core", true, AltMan.currentAltGUID);
    AltMan.Data:GetAltData("alt-data-daily", true, AltMan.currentAltGUID);
    AltMan.Data:GetAltData("alt-data-weekly", true, AltMan.currentAltGUID);
end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:GetData(type, refresh, altKey, alt)
    local dataSources = AltMan.Data.dataSourcesTypes[type];

    if (refresh or AltMan.Data.data[type] == nil) then
        AltMan.Data.data[type] = {}
        for _, source in Spairs(dataSources, CompareDataSources) do
            local value = AltMan.DataSources[source]();
            AltMan.Data.data[type][source] = value;
        end
    end
    return AltMan.Data.data[type];
end

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
function AltMan.Data:GetAltData(type, refresh, altKey, alt)

    -- strip "alt-data-" from the type in order to match it in the datasources
    type = string.gsub(type, "alt%-data%-", "");
    local dataSources = AltMan.Data.dataSourcesTypes["alt-data"][type];

    -- init the ald data if needed
    AltMan.Data.data["alt-data"] = AltMan.Data.data["alt-data"] or {};
    AltMan.Data.data["alt-data"][altKey] = AltMan.Data.data["alt-data"][altKey] or {}

    -- if we don't have data in the destination gather it
    if (refresh or AltMan.Data.data["alt-data"][altKey][type] == nil) then

        -- reset the alt
        AltMan.Data.data["alt-data"][altKey][type] = {}

        -- if this is the currently logged alt - then we need to use the data sources
        if (altKey == AltMan.currentAltGUID) then
            for _, source in Spairs(dataSources, CompareDataSources) do
                local value = AltMan.DataSources[source]();
                AltMan.Data.data["alt-data"][altKey][type][source] = value;
            end

            -- if this is another alt we need to rely on the saved data
        else
            for _, source in Spairs(dataSources, CompareDataSources) do
                local value = alt[source] or "N/A";
                AltMan.Data.data["alt-data"][altKey][type][source] = value;
            end
        end
    end

    return AltMan.Data.data["alt-data"][altKey][type]
end
