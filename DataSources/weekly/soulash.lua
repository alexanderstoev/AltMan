local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.soulash = function()

    -- anima reservoir quest IDs
    -- https://www.wowhead.com/quest=62935/remnants-of-hope
    local questIDs = {62935, 62966, 62969, 60146, 62836}

    for _, questID in pairs(questIDs) do

        -- check if the quest is marked as completed
        if (C_QuestLog.IsComplete(questID)) then
            return AltMan.translations["en"]["done"];

            -- check if the quest is marked as completed
        elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
            return AltMan.translations["en"]["done"];

            -- check if we have the quest in the log
        elseif (not (C_QuestLog.GetLogIndexForQuestID(questID) == nil)) then
            local data = C_QuestLog.GetQuestObjectives(questID)[1]
            if (not (data == nil)) then
                return data.numFulfilled .. "/" .. data.numRequired;
            end
        end
    end

    return AltMan.translations["en"]["notfound"];
end
