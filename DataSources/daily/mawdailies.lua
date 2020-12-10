local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.mawdailies = function()

    -- wow dailies IDs
    local questIDs = {63050, 63072, 63047, 63031, 63179, 63039}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        -- get quest title
        local questTitle = C_QuestLog.GetTitleForQuestID(questID);

        if (not (questTitle == nil)) then

            -- get quest remainig minutes
            -- it will be nil if the quest is not available
            local remainingMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID)

            if not (remainingMinutes == nil) then
                -- check if the quest is marked as completed
                if (C_QuestLog.IsComplete(questID)) then
                    table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                    -- check if the quest is marked as completed
                elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
                    table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                else
                    table.insert(returnSrings, questTitle .. ":\n" .. remainingMinutes .. " mins remaining");
                end
            end
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["notfound"];
    end
    return table.concat(returnSrings, "\n");
end
