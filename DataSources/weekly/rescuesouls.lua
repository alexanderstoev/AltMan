local _, AltMan = ...;

if (AltMan.DataSources == nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.rescuesouls = function()

    -- anima reservoir quest IDs
    local questIDs = {61325, 61331, 61332, 61333, 61334, 62858, 62859, 62860, 62861, 62862, 62863, 62864, 62865, 62866,
                      62867, 62868, 62869, 63024, 63025, 63026, 63027}

    local remainingMinutes = 0

    for _, questID in pairs(questIDs) do

        -- there are four quests up at the same time
        -- one for each covenant
        -- no need to detect the covenant so just taking on the is not nil
        remainingMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID) or remainingMinutes;

        -- check if the quest is marked as completed
        if (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
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
