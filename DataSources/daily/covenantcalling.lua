local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.covenantcalling = function()

    -- anima reservoir quest IDs
    -- https://shadowlands.wowhead.com/search?q=Replenish+the+Reservoir
    local questIDs = {60358, 60372, 60380, 60383, 60391, 60393, 60395, 60396, 60397, 60400, 60403, 60407, 60412, 60415,
                      60418, 60419, 60420, 60424, 60425, 60426, 60427, 60429, 60430, 60431, 60432, 60435, 60434, 60439,
                      60442, 60447, 60448, 60449, 60450, 60465}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_TaskQuest.GetQuestInfoByQuestID(questID);
        local remainingMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID);

        -- check if the quest is active
        if (not (remainingMinutes == nil)) then

            -- chck if the quest is taken
            if (not C_QuestLog.IsOnQuest(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["nottaken"] .. ' / ' .. GetRemainingTime(remainingMinutes * 60) .. " remaining");

                -- check if the quest is marked as completed
            elseif (C_QuestLog.IsComplete(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                -- check if the quest is marked as completed
            elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                -- check if we have the quest in the log
            elseif (not (C_QuestLog.GetLogIndexForQuestID(questID) == nil)) then
                local data = C_QuestLog.GetQuestObjectives(questID)[1]

                if (not (data == nil)) then
                    if (data.type == "progressbar") then
                        table.insert(returnSrings, questTitle .. ":\n" .. GetQuestProgressBarPercent(questID) .. "%".. ' / ' .. GetRemainingTime(remainingMinutes * 60) .. " remaining");
                    else
                        table.insert(returnSrings, questTitle .. ":\n" .. data.numFulfilled .. "/" .. data.numRequired.. ' / ' .. GetRemainingTime(remainingMinutes * 60) .. " remaining");
                    end
                end
            else
                table.insert(returnSrings,
                    questTitle .. ":\n" .. GetRemainingTime(remainingMinutes * 60) .. " remaining");
            end
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["notfound"];
    end

    return table.concat(returnSrings, "\n \n");
end
