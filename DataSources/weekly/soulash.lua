local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.soulash = function()

    -- anima reservoir quest IDs
    -- https://www.wowhead.com/quest=62935/remnants-of-hope
    local questIDs = {62935, 62966, 62969, 60146, 62836}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_QuestLog.GetTitleForQuestID(questID);

        -- check if the quest is active
        if (not (questTitle == nil)) then

            -- check if the quest is marked as completed
            if (not (C_QuestLog.IsComplete(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID))) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["notdone"]);
            end
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["done"];

    end
    return table.concat(returnSrings, "\n \n");
end
