local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.worldboss = function()

    -- world boss quest IDs
    local questIDs = {61813, 61814, 61815, 61816}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_TaskQuest.GetQuestInfoByQuestID(questID);

        if (C_QuestLog.IsComplete(questID)) then
            table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"] .. "|cFF00FF00");

            -- check if the quest is marked as completed
        elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
            table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"] .. "|cFF00FF00");
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["notfound"];
    end

    return table.concat(returnSrings, "\n \n");
end
