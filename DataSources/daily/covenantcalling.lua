local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.covenantcalling = function()

    -- anima reservoir quest IDs
    -- https://shadowlands.wowhead.com/search?q=Replenish+the+Reservoir
    local questIDs = {60424, 60419, 60418, 60425, 60430, 60429, 60434, 60432, 60380, 60372, 60391, 60393, 60395, 60400,
                      60465, 60439, 60442, 60447, 60450, 60358, 60415, 60403, 60407, 60412}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_QuestLog.GetTitleForQuestID(questID);

        if (not (questTitle == nil)) then

            -- check if the quest is marked as completed
            if (C_QuestLog.IsComplete(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                -- check if the quest is marked as completed
            elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                -- check if we have the quest in the log
            elseif (not (C_QuestLog.GetLogIndexForQuestID(questID) == nil)) then
                local data = C_QuestLog.GetQuestObjectives(questID)[1]

                if (not (data == nil)) then
                    if (data.type == "progressbar") then
                        table.insert(returnSrings, questTitle .. ":\n" .. GetQuestProgressBarPercent(questID) .. "%");
                    else
                        table.insert(returnSrings, questTitle .. ":\n" .. data.numFulfilled .. "/" .. data.numRequired);
                    end
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
