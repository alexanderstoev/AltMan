local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.dungeonquests = function()

    -- dungeon quest IDs
    -- https://shadowlands.wowhead.com/search?q=Trading+Favors
    local questIDs = {60242, 60243, 60244, 60245, 60246, 60247, 60248, 60249}

    local removeString = "Trading Favors: "

    local returnSrings = {}

    for _, questID in pairs(questIDs) do

        local questTitle = C_QuestLog.GetTitleForQuestID(questID);

        if (not (questTitle == nil)) then

            questTitle = string.gsub(questTitle, removeString, "")

            -- check if the quest is marked as completed
            if (C_QuestLog.IsComplete(questID)) then
                table.insert(returnSrings, questTitle .. ": " .. AltMan.translations["en"]["done"]);

                -- check if the quest is marked as completed
            elseif (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
                table.insert(returnSrings, questTitle .. ": " .. AltMan.translations["en"]["done"]);

                -- check if we have the quest in the log
            elseif (not (C_QuestLog.GetLogIndexForQuestID(questID) == nil)) then
                table.insert(returnSrings, questTitle .. ": " .. AltMan.translations["en"]["notdone"]);
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

    return table.concat(returnSrings, "\n");
end
