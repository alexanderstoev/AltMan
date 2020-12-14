local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.dungeonquests = function()

    -- dungeon quest IDs
    -- https://www.wowhead.com/search?q=a+valuable+find
    -- https://shadowlands.wowhead.com/search?q=Trading+Favors
    local questIDs = {60242, 60243, 60244, 60245, 60246, 60247, 60248, 60249, 60250, 60252, 60253, 60256}

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_QuestLog.GetTitleForQuestID(questID);
        
        -- check if the quest is active
        if (not (questTitle == nil)) then

            -- check if the quest is marked as completed
            if (C_QuestLog.IsComplete(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);

                -- check if the quest is marked as completed
            elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["done"]);
                
                -- check if we have the quest in the log
            elseif (C_QuestLog.IsOnQuest(questID)) then
                table.insert(returnSrings, questTitle .. ":\n" .. AltMan.translations["en"]["notdone"]);
            end
        end
    end

    local foundQuests = sizeOfTable(returnSrings);
    if (foundQuests == 0) then
        return AltMan.translations["en"]["notfound"];
    end
    if (foundQuests == 1) then
        table.insert(returnSrings, AltMan.translations["en"]["secondquestnotfound"])
    end

    return table.concat(returnSrings, "\n \n");
end
