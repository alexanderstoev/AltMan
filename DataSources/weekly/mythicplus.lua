local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.mythicplus = function()

    local returnSrings = {}

    local mpData = C_WeeklyRewards.GetActivities(Enum.WeeklyRewardChestThresholdType.MythicPlus);
    for _, v in pairs(mpData) do
        if (v["level"] > 0) then
            local tier = "tier" .. v["threshold"];
            table.insert(returnSrings, AltMan.translations["en"]["mythicplus"][tier] .. ": " .. v["level"])
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["notfound"];
    end

    return table.concat(returnSrings, "\n \n");
end
