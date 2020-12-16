local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.animaquest = function()

    -- anima reservoir quest IDs
    -- https://shadowlands.wowhead.com/search?q=Replenish+the+Reservoir
    local questIDs = {61981, 61982, 61983, 61984, 62441}

    local remainingMinutes = 0

    for _, questID in pairs(questIDs) do

        -- there are four quests up at the same time
        -- one for each covenant
        -- no need to detect the covenant so just taking on the is not nil
        remainingMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID) or remainingMinutes;

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
                return
                    data.numFulfilled .. "/" .. data.numRequired .. " - " .. GetRemainingTime(remainingMinutes * 60) ..
                        " remaining";
            end
        end
    end

    return AltMan.translations["en"]["notfound"] .. " - " .. GetRemainingTime(remainingMinutes * 60) .. " remaining";
end
