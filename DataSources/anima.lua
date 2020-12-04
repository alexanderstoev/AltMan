local _, AltMan = ...;

if (AltMan.DataSources== nil) then
    AltMan.DataSources = {}
end

AltMan.DataSources.animaquest = function () 

    -- anima reservoir quest IDs
    -- https://shadowlands.wowhead.com/search?q=Replenish+the+Reservoir
    local questIDs = {
        61981,
        61982,
        61983,
        61984,
    }
    
    for _, questID in pairs(questIDs) do 

        -- check if the quest is marked as completed
        if (C_QuestLog.IsComplete(questID)) then
            return AltMan.translations["en"]["done"];
        end

        -- check if we have the quest in the log
        if (not(C_QuestLog.GetLogIndexForQuestID(questID) == nil)) then
            local data = C_QuestLog.GetQuestObjectives(questID)[1]
            if (not(data == nil)) then
                return data.numFulfilled .. "/" .. data.numRequired;
            end 
        end
    end

    return AltMan.translations["en"]["notfound"];
end